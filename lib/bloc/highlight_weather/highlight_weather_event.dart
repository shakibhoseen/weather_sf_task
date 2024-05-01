part of 'highlight_weather_bloc.dart';

sealed class HighlightWeatherEvent extends Equatable {
  const HighlightWeatherEvent();

  @override
  List<Object> get props => [];
}

class HighLightWeatherChangedEvent extends HighlightWeatherEvent{
   final Hour hour;

   const HighLightWeatherChangedEvent(this.hour);

   @override
   List<Object> get props => [hour];

}
