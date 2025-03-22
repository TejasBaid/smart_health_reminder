// lib/modules/water_tracking/widgets/delhi_weather_card.dart
import 'package:flutter/material.dart';
import '../../../core/const_imports.dart';
import '../../../services/weather_service.dart';
import '../../posture_tracking/widgets/posture_status_card.dart';


class WeatherCard extends StatefulWidget {
  final ValueNotifier<double> dailyGoalNotifier;

  const WeatherCard({
    Key? key,
    required this.dailyGoalNotifier,
  }) : super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  final WeatherService _weatherService = WeatherService();
  final HydrationRecommendationService _recommendationService = HydrationRecommendationService();

  bool _isLoading = true;
  String _errorMessage = '';
  double _temperature = 0.0;
  double _recommendedIntake = 2000.0;
  String _advice = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      setState(() => _isLoading = true);

      final weatherData = await _weatherService.getWeatherForDelhi();
      final temperature =  _weatherService.getCurrentTemperature(weatherData);
      // final recommendedIntake = _recommendationService.getRecommendedIntake(temperature);
      // final advice = _recommendationService.getHydrationAdvice(temperature);
      final recommendedIntake = _recommendationService.getRecommendedIntake(34);
      final advice = _recommendationService.getHydrationAdvice(34);

      setState(() {
        // _temperature = temperature;
        _temperature = 34;
        _recommendedIntake = recommendedIntake;
        _advice = advice;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _isLoading
          ? _buildLoadingState()
          : _errorMessage.isNotEmpty
          ? _buildErrorState()
          : _buildWeatherContent(),
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Icon(Icons.cloud_off, size: 40, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            _errorMessage,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _fetchWeatherData,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConsts.tealPopAccent,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getWeatherIcon(),
                color: _getTemperatureColor(),
                size: 28,
              ),
              const SizedBox(width: 10),
              const Text(
                'Weather',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.refresh, color: _getTemperatureColor()),
                onPressed: _fetchWeatherData,
                iconSize: 20,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                '${_temperature.toStringAsFixed(1)}°C',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _getTemperatureColor(),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${_recommendedIntake.toInt()} ml',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getTemperatureColor(),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Temperature-based hydration advice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getTemperatureColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.water_drop,
                  color: _getTemperatureColor(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _advice,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _getTemperatureColor(),
              boxShadow: [
                BoxShadow(
                  color: ColorConsts.tealPopAccent.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Ripple background
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const StaticRippleBackgroundCard(),
                  ),
                ),
                // Button content
                ElevatedButton(
                  onPressed: () {
                    widget.dailyGoalNotifier.value = _recommendedIntake;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Daily goal updated to ${_recommendedIntake.toInt()} ml'
                        ),
                        backgroundColor: ColorConsts.tealPopAccent,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Update Hydration Goal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  IconData _getWeatherIcon() {
    if (_temperature > 35) {
      return Icons.wb_sunny;
    } else if (_temperature > 30) {
      return HugeIcons.strokeRoundedSun01;
    } else if (_temperature > 25) {
      return HugeIcons.strokeRoundedSunCloud01;
    } else if (_temperature > 15) {
      return HugeIcons.strokeRoundedCloud;
    } else {
      return HugeIcons.strokeRoundedSnow;
    }
  }

  Color _getTemperatureColor() {
    if (_temperature > 35) {
      return Colors.redAccent;
    } else if (_temperature > 30) {
      return Colors.orange;
    } else if (_temperature > 25) {
      return Colors.amber;
    } else if (_temperature > 15) {
      return ColorConsts.tealPopAccent;
    } else {
      return Colors.blue;
    }
  }
}
