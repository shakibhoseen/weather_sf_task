part of 'forecast_bloc.dart';

sealed class ForecastState extends Equatable {
  const ForecastState();
  
  @override
  List<Object> get props => [];
}

final class ForecastInitial extends ForecastState {}
final class ForecastChangedState extends ForecastState {
  final int changeIndex;


  const ForecastChangedState(this.changeIndex, );


  @override
  List<Object> get props => [changeIndex, ];
}
