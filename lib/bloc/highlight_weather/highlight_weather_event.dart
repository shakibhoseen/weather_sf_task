part of 'highlight_weather_bloc.dart';

sealed class HighlightWeatherEvent extends Equatable {
  const HighlightWeatherEvent();

  @override
  List<Object> get props => [];
}

class HighLightWeatherChangedEvent extends HighlightWeatherEvent{
   final HourAndNowCombine hourNow;

   const HighLightWeatherChangedEvent(this.hourNow);

   @override
   List<Object> get props => [hourNow];

}
