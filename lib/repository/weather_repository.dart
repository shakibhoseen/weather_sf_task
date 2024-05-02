import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:weather_sf_task/model/network/weather_parrent_model.dart';
import 'package:weather_sf_task/res/app_url.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class WeatherRepository {
  final BaseApiServices _apiServices = NetworkAPiServices();

  Future<WeatherParentData> getFetchForecastWeather(Position position) async {
   // try {
      dynamic response = await _apiServices.getApiResponse(AppUrls(location: '${position.latitude},${position.latitude}').getUrl());
      log("response"+ response.toString());
      return WeatherParentData.fromJson(response);
    // } catch (error) {
    //   rethrow;
    // }
  }
}