import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class PostureDetectionService {
  final StreamController<bool> _postureStatusController = StreamController<bool>.broadcast();
  final StreamController<double> _postureQualityController = StreamController<double>.broadcast();
  final StreamController<Color> _backgroundColorController = StreamController<Color>.broadcast();

  Stream<bool> get postureStatus => _postureStatusController.stream;
  Stream<double> get postureQuality => _postureQualityController.stream;
  Stream<Color> get backgroundColor => _backgroundColorController.stream;

  bool _isGoodPosture = true;
  double _currentQuality = 100.0;
  int _goodPostureMinutes = 0;
  int _badPostureMinutes = 0;

  double _referenceX = 0.0;
  double _referenceY = 0.0;
  double _referenceZ = 9.8; // Default to Earth's gravity
  bool _isCalibrated = false;

  double _maxAllowedAngleDiff = 20.0; // Degrees
  double _maxAllowedMagnitudeDiff = 1.5; // G-force units

  String _currentMode = "sitting"; // "sitting", "standing", "walking"

  StreamSubscription? _accelerometerSubscription;
  Timer? _durationTimer;

  final Color _goodPostureColor = const Color(0xFF30BFC7);
  final Color _badPostureColor = const Color(0xFFE57373);

  List<Vector3D> _accelerometerBuffer = [];
  final int _bufferSize = 15;

  Future<void> startDetection() async {
    await _loadCalibrationData();

    try {
      _accelerometerSubscription = accelerometerEvents.listen(
            (AccelerometerEvent event) {
          _processAccelerometerData(event);
        },
        onError: (error) {
          print("Accelerometer error: $error");
        },
      );
    } catch (e) {
      print("Failed to initialize accelerometer: $e");
      // Show error to user
    }

    _durationTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      if (_isGoodPosture) {
        _goodPostureMinutes++;
      } else {
        _badPostureMinutes++;
      }
    });

    _backgroundColorController.add(_goodPostureColor);
  }

  Future<void> calibrate(String mode) async {
    _currentMode = mode;

    List<AccelerometerEvent> samples = [];
    int samplesToCollect = 30; // About 3 seconds of data

    Completer<void> completer = Completer<void>();

    late StreamSubscription<AccelerometerEvent> subscription;

    subscription = accelerometerEvents.listen((event) {
      samples.add(event);
      if (samples.length >= samplesToCollect) {
        subscription.cancel();
        completer.complete();
      }
    });

    await completer.future;

    samples.sort((a, b) => a.x.compareTo(b.x));
    _referenceX = samples[samples.length ~/ 2].x;

    samples.sort((a, b) => a.y.compareTo(b.y));
    _referenceY = samples[samples.length ~/ 2].y;

    samples.sort((a, b) => a.z.compareTo(b.z));
    _referenceZ = samples[samples.length ~/ 2].z;



    _isCalibrated = true;
    await _saveCalibrationData();
  }


  void _processAccelerometerData(AccelerometerEvent event) {
    if (!_isCalibrated) {
      return;
    }

    _accelerometerBuffer.add(Vector3D(event.x, event.y, event.z));
    if (_accelerometerBuffer.length > _bufferSize) {
      _accelerometerBuffer.removeAt(0);
    }

    Vector3D filteredVector = _applyMedianFilter();

    double angleDiff = _calculateAngleDifference(
        filteredVector.x, filteredVector.y, filteredVector.z
    );

    double magnitudeDiff = _calculateMagnitudeDifference(
        filteredVector.x, filteredVector.y, filteredVector.z
    );

    double angleQuality = 100 - (angleDiff / _maxAllowedAngleDiff * 100).clamp(0.0, 100.0);
    double magnitudeQuality = 100 - (magnitudeDiff / _maxAllowedMagnitudeDiff * 100).clamp(0.0, 100.0);

    double combinedQuality = (angleQuality * 0.7) + (magnitudeQuality * 0.3);

    _currentQuality = _currentQuality * 0.7 + combinedQuality * 0.3;

    double threshold;
    switch (_currentMode) {
      case "sitting":
        threshold = 70.0;
        break;
      case "standing":
        threshold = 75.0;
        break;
      case "walking":
        threshold = 65.0;
        break;
      default:
        threshold = 70.0;
    }

    bool newPostureStatus = _currentQuality >= threshold;

    if (newPostureStatus != _isGoodPosture) {
      _isGoodPosture = newPostureStatus;
      _postureStatusController.add(_isGoodPosture);
      _backgroundColorController.add(_isGoodPosture ? _goodPostureColor : _badPostureColor);
    }

    _postureQualityController.add(_currentQuality);
  }

  double _calculateAngleDifference(double x, double y, double z) {
    Vector3D currentVec = Vector3D(x, y, z).normalized();
    Vector3D referenceVec = Vector3D(_referenceX, _referenceY, _referenceZ).normalized();

    double dotProduct = currentVec.x * referenceVec.x +
        currentVec.y * referenceVec.y +
        currentVec.z * referenceVec.z;

    dotProduct = dotProduct.clamp(-1.0, 1.0);

    return math.acos(dotProduct) * 180 / math.pi;
  }

  double _calculateMagnitudeDifference(double x, double y, double z) {
    double currentMagnitude = math.sqrt(x * x + y * y + z * z);
    double referenceMagnitude = math.sqrt(
        _referenceX * _referenceX +
            _referenceY * _referenceY +
            _referenceZ * _referenceZ
    );

    return (currentMagnitude - referenceMagnitude).abs();
  }

  Vector3D _applyMedianFilter() {
    if (_accelerometerBuffer.isEmpty) {
      return Vector3D(0, 0, 0);
    }

    List<double> xValues = _accelerometerBuffer.map((v) => v.x).toList();
    List<double> yValues = _accelerometerBuffer.map((v) => v.y).toList();
    List<double> zValues = _accelerometerBuffer.map((v) => v.z).toList();

    xValues.sort();
    yValues.sort();
    zValues.sort();

    int middle = _accelerometerBuffer.length ~/ 2;
    return Vector3D(xValues[middle], yValues[middle], zValues[middle]);
  }

  Future<void> _saveCalibrationData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('referenceX', _referenceX);
    await prefs.setDouble('referenceY', _referenceY);
    await prefs.setDouble('referenceZ', _referenceZ);
    await prefs.setString('postureMode', _currentMode);
    await prefs.setBool('isCalibrated', true);
  }

  Future<void> _loadCalibrationData() async {
    final prefs = await SharedPreferences.getInstance();
    _isCalibrated = prefs.getBool('isCalibrated') ?? false;

    if (_isCalibrated) {
      _referenceX = prefs.getDouble('referenceX') ?? 0.0;
      _referenceY = prefs.getDouble('referenceY') ?? 0.0;
      _referenceZ = prefs.getDouble('referenceZ') ?? 9.8;
      _currentMode = prefs.getString('postureMode') ?? "sitting";

      // Set appropriate thresholds based on mode
      switch (_currentMode) {
        case "sitting":
          _maxAllowedAngleDiff = 15.0;
          _maxAllowedMagnitudeDiff = 1.0;
          break;
        case "standing":
          _maxAllowedAngleDiff = 10.0;
          _maxAllowedMagnitudeDiff = 0.8;
          break;
        case "walking":
          _maxAllowedAngleDiff = 25.0;
          _maxAllowedMagnitudeDiff = 2.5;
          break;
      }
    }
  }

  Map<String, dynamic> getPostureMetrics() {
    return {
      'isGoodPosture': _isGoodPosture,
      'quality': _currentQuality,
      'goodPostureMinutes': _goodPostureMinutes,
      'badPostureMinutes': _badPostureMinutes,
      'isCalibrated': _isCalibrated,
      'mode': _currentMode,
    };
  }

  // Cleanup
  void dispose() {
    _accelerometerSubscription?.cancel();
    _durationTimer?.cancel();
    _postureStatusController.close();
    _postureQualityController.close();
    _backgroundColorController.close();
  }
}

class Vector3D {
  final double x;
  final double y;
  final double z;

  Vector3D(this.x, this.y, this.z);

  double get magnitude => math.sqrt(x * x + y * y + z * z);

  Vector3D normalized() {
    double mag = magnitude;
    if (mag > 0) {
      return Vector3D(x / mag, y / mag, z / mag);
    }
    return Vector3D(0, 0, 0);
  }
}
