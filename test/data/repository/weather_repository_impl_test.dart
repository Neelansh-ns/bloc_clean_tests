import 'dart:io';

import 'package:bloc_clean_tests/core/error/exception.dart';
import 'package:bloc_clean_tests/core/error/failure.dart';
import 'package:bloc_clean_tests/data/models/weather_model.dart';
import 'package:bloc_clean_tests/data/repository/weather_repository_impl.dart';
import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherRepositoryImpl weatherRepositoryImpl;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    name: 'New York',
    temp: 22.0,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    temperature: 22.0,
  );

  const testCityName = 'New York';

  group('get current weather', () {
    test('should return current weather when a call to data source is successful', () async {
      //arrange
      when(mockWeatherRemoteDataSource.getWeather(testCityName)).thenAnswer((_) async => testWeatherModel);
      //act
      final result = await weatherRepositoryImpl.getWeather(testCityName);
      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('should return a server failure when call to data source is unsuccessful', () async {
      //arrange
      when(mockWeatherRemoteDataSource.getWeather(testCityName)).thenThrow(ServerException());
      //act
      final result = await weatherRepositoryImpl.getWeather(testCityName);
      //assert
      expect(result, equals(const Left(ServerFailure('Error while getting weather data'))));
    });

    test('should return a server failure when device has not internet', () async {
      //arrange
      when(mockWeatherRemoteDataSource.getWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));
      //act
      final result = await weatherRepositoryImpl.getWeather(testCityName);
      //assert
      expect(result, equals(const Left(NetworkFailure('Failed to connect to the internet'))));
    });
  });
}
