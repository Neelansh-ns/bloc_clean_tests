import 'package:bloc_clean_tests/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testWeatherModel = WeatherModel(
    name: 'London',
    temp: 22.0,
  );
  test('should be a subclass of weather model', () {
    //assert
    expect(testWeatherModel, isA<WeatherModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON city name is a string', () async {
      //arrange
      final Map<String, dynamic> jsonMap = {
        'name': 'London',
        'main': {'temp': 22.0},
      };
      //act
      final result = WeatherModel.fromJson(jsonMap);
      //assert
      expect(result, testWeatherModel);
    });

    test('should return an exception when invalid model when the JSON city name is an integer', () {
      //arrange
      final Map<String, dynamic> jsonMap = {
        'name': 123,
        'main': {'temp': 22.0},
      };
      //act

      void result() => WeatherModel.fromJson(jsonMap);
      //assert
      expect(result, throwsA(isA<TypeError>()));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //act
      final result = testWeatherModel.toJson();
      //assert
      final expectedMap = {
        'name': 'London',
        'main': {'temp': 22.0},
      };
      expect(result, expectedMap);
    });
  });
}
