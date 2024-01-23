import 'dart:io';

import 'package:bloc_clean_tests/core/error/exception.dart';
import 'package:bloc_clean_tests/core/error/failure.dart';
import 'package:bloc_clean_tests/data/data_sources/remote_data_source.dart';
import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';
import 'package:bloc_clean_tests/domain/repo/weather_repo.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Error while getting weather data'));
    } on SocketException {
      return const Left(NetworkFailure('Failed to connect to the internet'));
    }
  }
}
