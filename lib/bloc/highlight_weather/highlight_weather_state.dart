part of 'highlight_weather_bloc.dart';

sealed class HighlightWeatherState extends Equatable {
  const HighlightWeatherState();
  
  @override
  List<Object> get props => [];
}

final class HighlightWeatherInitial extends HighlightWeatherState {}

class HighLightWeatherChangedState extends HighlightWeatherState{
  final Hour hour;
  const HighLightWeatherChangedState(this.hour);

  @override
  List<Object> get props => [hour];

}