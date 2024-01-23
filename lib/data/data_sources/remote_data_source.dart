import 'dart:convert';

import 'package:bloc_clean_tests/core/error/exception.dart';
import 'package:bloc_clean_tests/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  /// Calls the http://api.weatherstack.com/current
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather(String city) async {
    final response = await client.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=cc95d932d5a45d33a9527d5019475f2c'),
    );
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}