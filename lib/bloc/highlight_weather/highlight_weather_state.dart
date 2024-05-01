part of 'highlight_weather_bloc.dart';

sealed class HighlightWeatherState extends Equatable {
  const HighlightWeatherState();
  
  @override
  List<Object> get props => [];
}

final class HighlightWeatherInitial extends HighlightWeatherState {}

class HighLightWeatherChangedState extends HighlightWeatherState{
  final HourAndNowCombine hourNow;
  const HighLightWeatherChangedState(this.hourNow);

  @override
  List<Object> get props => [hourNow];

}