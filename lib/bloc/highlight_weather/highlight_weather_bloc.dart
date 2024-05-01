
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/model/network/weather_parrent_model.dart';

import '../../model/local/hour_current_combine.dart';

part 'highlight_weather_event.dart';
part 'highlight_weather_state.dart';

class HighlightWeatherBloc extends Bloc<HighlightWeatherEvent, HighlightWeatherState> {
  HighlightWeatherBloc() : super(HighlightWeatherInitial()) {
    on<HighLightWeatherChangedEvent>((event, emit) {
      emit(HighLightWeatherChangedState(event.hourNow));
    });
  }
}
