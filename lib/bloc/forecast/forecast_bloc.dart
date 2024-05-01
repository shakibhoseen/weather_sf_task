
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/model/network/weather_parrent_model.dart';

part 'forecast_event.dart';

part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastInitial()) {
    on<ForecastChangedEvent>((event, emit) {
      emit(ForecastChangedState(
          event.changeIndex,));
    });
  }
}
