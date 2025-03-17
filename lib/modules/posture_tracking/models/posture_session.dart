class PostureSession {
  final DateTime startTime;
  final bool isGoodPosture;
  final double quality;
  DateTime? endTime;

  PostureSession({
    required this.startTime,
    required this.isGoodPosture,
    required this.quality,
    this.endTime,
  });

  int get durationInMinutes {
    final DateTime end = endTime ?? DateTime.now();
    return end.difference(startTime).inMinutes;
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isGoodPosture': isGoodPosture,
      'quality': quality,
    };
  }

  factory PostureSession.fromMap(Map<String, dynamic> map) {
    return PostureSession(
      startTime: DateTime.parse(map['startTime']),
      isGoodPosture: map['isGoodPosture'],
      quality: map['quality'],
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
    );
  }
}
