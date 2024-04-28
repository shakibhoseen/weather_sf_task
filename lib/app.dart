import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/bloc/degree/bloc/degree_bloc.dart';
import 'package:weather_sf_task/bloc/weather/weather_bloc_bloc.dart';

import 'app_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBlocBloc()),
        BlocProvider(create: (context) => DegreeBloc()),
      ],
      child:  const MyAppView(),
    );
  }
}