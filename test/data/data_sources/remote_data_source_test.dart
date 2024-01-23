import 'package:bloc_clean_tests/core/error/exception.dart';
import 'package:bloc_clean_tests/data/data_sources/remote_data_source.dart';
import 'package:bloc_clean_tests/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get current weather', () {
    test('should return weather model when response is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=London&appid=cc95d932d5a45d33a9527d5019475f2c'))).thenAnswer((_) async => http.Response('{"name": "London", "main" : {"temp": 22.0}}', 200));
      //act
      final result = await weatherRemoteDataSourceImpl.getWeather('London');
      //assert
      expect(result, isA<WeatherModel>());
    });

    test('should throw server exception when the response code is NOT 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=London&appid=cc95d932d5a45d33a9527d5019475f2c'))).thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = weatherRemoteDataSourceImpl.getWeather('London');
      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
