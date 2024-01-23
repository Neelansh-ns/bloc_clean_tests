import 'package:bloc_clean_tests/data/data_sources/remote_data_source.dart';
import 'package:bloc_clean_tests/domain/repo/weather_repo.dart';
import 'package:bloc_clean_tests/domain/usecases/get_current_weather.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
