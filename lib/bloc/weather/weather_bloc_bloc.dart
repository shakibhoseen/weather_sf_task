import 'dart:developer';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_sf_task/database/hive/hive_data_manage.dart';
import 'package:weather_sf_task/model/weather_parrent_model.dart';
import 'package:weather_sf_task/repository/weather_repository.dart';




part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherParentData? saveWeather;
  MyHiveRepository myHive ;
  WeatherBlocBloc() : myHive = MyHiveRepository(), super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      final local = await myHive.getStoreData();
      if(event.isConnected){

      }
      else if(saveWeather!=null || local!=null){
        emit(WeatherBlocSuccess(saveWeather ?? local! ));
        return;
      }
      log('...........................new fetch');
      emit(WeatherBlocLoading());
      try {

        // Weather weather = await wf.currentWeatherByLocation(
        //     event.position.latitude, event.position.longitude);

        final weather =await  WeatherRepository().getFetchForecastWeather();
        log('hey ');
        saveWeather = weather;
        log(weather.toJson().toString());
         MyHiveRepository().saveData(weather);

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        log('hey $e');
        emit(WeatherBlocFailure());
      }
    });
  }
}