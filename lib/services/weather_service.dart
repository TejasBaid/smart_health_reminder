import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = 'bd5e378503939ddaee76f12ad7a97608';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> getWeatherForDelhi() async {
    final response = await http.get(
      Uri.parse('$baseUrl/weather?q=Delhi,in&units=metric&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  double getCurrentTemperature(Map<String, dynamic> weatherData) {
    return weatherData['main']['temp'];
  }
}


class HydrationRecommendationService {
  double getRecommendedIntake(double temperatureCelsius) {
    double baseRecommendation = 2000.0;

    if (temperatureCelsius > 35) {
      return baseRecommendation * 1.5;
    } else if (temperatureCelsius > 30) {
      return baseRecommendation * 1.3;
    } else if (temperatureCelsius > 25) {
      return baseRecommendation * 1.15;
    } else if (temperatureCelsius < 15) {
      return baseRecommendation * 0.9;
    }

    return baseRecommendation;
  }

  String getHydrationAdvice(double temperatureCelsius) {
    if (temperatureCelsius > 35) {
      return "Extremely hot in Delhi today! Drink water frequently, even if you don't feel thirsty.";
    } else if (temperatureCelsius > 30) {
      return "It's hot in Delhi today! Increase your water intake and avoid caffeinated beverages.";
    } else if (temperatureCelsius > 25) {
      return "Warm weather in Delhi today. Remember to stay hydrated throughout the day.";
    } else if (temperatureCelsius < 15) {
      return "It's cooler in Delhi today, but don't forget to maintain your hydration.";
    } else {
      return "Pleasant weather in Delhi today. Maintain regular water intake for optimal health.";
    }
  }
}
