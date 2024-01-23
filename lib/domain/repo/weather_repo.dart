import 'package:bloc_clean_tests/core/error/failure.dart';
import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName);
}
