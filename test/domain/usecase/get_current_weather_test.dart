import 'package:bloc_clean_tests/domain/entities/weather_entity.dart';
import 'package:bloc_clean_tests/domain/usecases/get_current_weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const tWeatherEntity = WeatherEntity(cityName: 'London', temperature: 22.0);
  const tCityName = 'London';

  test('should get weather from the repository', () async {
    //arrange
    when(mockWeatherRepository.getWeather(tCityName)).thenAnswer((_) async => const Right(tWeatherEntity));

    //act
    final result = await getCurrentWeatherUseCase.execute(tCityName);

    //assert
    expect(result, const Right(tWeatherEntity));
  });
}
