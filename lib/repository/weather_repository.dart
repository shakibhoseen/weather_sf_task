import 'dart:developer';

import 'package:weather_sf_task/model/weather_parrent_model.dart';
import 'package:weather_sf_task/res/app_url.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class WeatherRepository {
  final BaseApiServices _apiServices = NetworkAPiServices();

  Future<WeatherParentData> getFetchForecastWeather() async {
   // try {
      dynamic response = await _apiServices.getApiResponse(AppUrls(location: '23.8041,90.4152').getUrl());
      log("response"+ response.toString());
      return WeatherParentData.fromJson(response);
    // } catch (error) {
    //   rethrow;
    // }
  }
}