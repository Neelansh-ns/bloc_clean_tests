import 'package:bloc_clean_tests/core/error/failure.dart';
import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';
import 'package:bloc_clean_tests/domain/repo/weather_repo.dart';
import 'package:dartz/dartz.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String cityName) async {
    return await weatherRepository.getWeather(cityName);
  }
}