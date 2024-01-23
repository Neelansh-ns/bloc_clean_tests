import 'package:bloc/bloc.dart';
import 'package:bloc_clean_tests/domain/usecases/get_current_weather.dart';
import 'package:bloc_clean_tests/presentation/bloc/weather_event.dart';
import 'package:bloc_clean_tests/presentation/bloc/weather_state.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(_onCityChanged, transformer: debounce(const Duration(milliseconds: 300)));
  }

  _onCityChanged(OnCityChanged event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final result = await getCurrentWeatherUseCase.execute(event.cityName);
    result.fold(
      (failure) => emit(WeatherError(message: failure.message)),
      (weatherEntity) => emit(WeatherLoaded(weatherEntity: weatherEntity)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
