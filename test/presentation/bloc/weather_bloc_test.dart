import 'package:bloc_clean_tests/core/error/failure.dart';
import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';
import 'package:bloc_clean_tests/presentation/bloc/weather_bloc.dart';
import 'package:bloc_clean_tests/presentation/bloc/weather_event.dart';
import 'package:bloc_clean_tests/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    temperature: 22.0,
  );

  const testCityName = 'New York';

  test('initial state should be empty', () {
    expect(weatherBloc.state, equals(WeatherEmpty()));
  });

  blocTest(
    'should emit [WeatherLoading, WeatherLoaded], when data is gotten successfully ',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer((_) async => const Right(testWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName: testCityName)),
    wait: const Duration(milliseconds: 300),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoaded(weatherEntity: testWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>('should emit [WeatherLoading, WeatherError] when get data is unsuccessful',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName))
            .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(cityName: testCityName)),
      wait: const Duration(milliseconds: 300),
      expect: () => [
            WeatherLoading(),
            const WeatherError(message: 'Server failure'),
          ]);
}
