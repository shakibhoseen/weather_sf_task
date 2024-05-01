import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/bloc/degree/degree_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';
import 'package:weather_sf_task/bloc/weather/weather_bloc_bloc.dart';

import 'app_view.dart';
import 'bloc/forecast/forecast_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBlocBloc()),
        BlocProvider(create: (context) => DegreeBloc()),
        BlocProvider(create: (context) => ForecastBloc()),
        BlocProvider(create: (context) => HighlightWeatherBloc()),
      ],
      child:  const MyAppView(),
    );
  }
}