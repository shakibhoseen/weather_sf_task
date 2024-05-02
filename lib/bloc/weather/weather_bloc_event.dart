part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final Position position;
  final bool isConnected;
  const FetchWeather(this.position, this.isConnected);

  @override
  List<Object> get props => [position];
}

class FetchWeatherFromHive extends WeatherBlocEvent {
  final WeatherParentData weatherParentData;
  const FetchWeatherFromHive(this.weatherParentData);

  @override
  List<Object> get props => [weatherParentData];
}