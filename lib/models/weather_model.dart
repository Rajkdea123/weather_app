class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final double windSpeed;
  final int humidity;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.windSpeed,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      condition: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
    );
  }
}
