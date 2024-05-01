part of 'forecast_bloc.dart';

sealed class ForecastEvent extends Equatable {
  const ForecastEvent();

  @override
  List<Object> get props => [];
}
class ForecastChangedEvent extends ForecastEvent{
  final int changeIndex;


  const ForecastChangedEvent(
      {required this.changeIndex});

}
