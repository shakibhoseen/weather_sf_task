import 'dart:developer';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_sf_task/database/hive/hive_data_manage.dart';
import 'package:weather_sf_task/model/network/weather_parrent_model.dart';
import 'package:weather_sf_task/repository/weather_repository.dart';

import '../../utils/utils.dart';




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
        //return;
      }else{
        emit(WeatherBlocLoading());  /// its only work when you have no save data ,
        /// log('...........................new fetch');
      }


      try {

        // Weather weather = await wf.currentWeatherByLocation(
        //     event.position.latitude, event.position.longitude);

        final weather =await  WeatherRepository().getFetchForecastWeather(event.position);
        log('hey ');
        saveWeather = weather;
        log(weather.toJson().toString());
         MyHiveRepository().saveData(weather);

        emit(WeatherBlocSuccess(weather));  /// if user have save data so why again we hit api?
        /// because we take care about latest data if you have a network connection
      } catch (e) {
        log('hey ${e}');
        /// if hive is available so we just want to show a Toast message not change state
        /// why? because user already have  alocal data so we dont want to interrupt replace UI with error data
        if(local==null){
          emit(WeatherBlocFailure(e.toString()));
        }else{
          Utils.showToastMessage('Opps! could not get Latest Data');
        }
        /// to alert someting for getting latest data , we just show toast

      }
    });
    on<FetchWeatherFromHive>((event, emit) => emit(WeatherBlocSuccess(event.weatherParentData)));
  }
}