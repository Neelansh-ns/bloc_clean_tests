import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  final String name;
  final double temp;

  const WeatherModel({
    required this.name,
    required this.temp,
  }) : super(cityName: name, temperature: temp);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['name'],
      temp: (json['main']['temp'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'main': {'temp': temp},
    };
  }

  WeatherEntity toEntity() {
    return WeatherEntity(cityName: name, temperature: temp);
  }
}
