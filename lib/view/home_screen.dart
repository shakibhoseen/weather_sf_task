import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/weather_bloc_bloc.dart';
import 'package:weather_sf_task/component/svg_show.dart';
import 'package:weather_sf_task/res/asset_names.dart';
import 'package:weather_sf_task/res/color.dart';
import 'package:weather_sf_task/res/text_font_style.dart';
import 'package:weather_sf_task/utils/helper_widget.dart';
import 'package:weather_sf_task/utils/utils.dart';

import '../model/weather_parrent_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void getLocation(BuildContext context)async{
     determinePosition().then((position) => context.read<WeatherBlocBloc>().add(FetchWeather(position)));
  }

  @override
  Widget build(BuildContext context) {
    getLocation(context);
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 40.w),
        decoration: const BoxDecoration(
          gradient:
          LinearGradient(colors: [AppColor.secondaryColor,
            AppColor.primaryColor,], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Column(
           children: [
             BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
               builder: (context, state){
                 if(state is WeatherBlocLoading){
                   return CircularProgressIndicator();
                 }else if( state is WeatherBlocFailure ){
                   return Text('Error ');
                 }else if(state is WeatherBlocSuccess){
                   return ui(state.weather);
                 }return Text('Initial');
               },),

           ],
          ),
        ),
      ),
    );
  }

  Widget ui(WeatherParentData weather){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Dhaka', style: TextFontStyle.headline32StyleOpenSansBold,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgShow(path: AssetNames.locationIconSvg),
            addHorizontalSpace(8.w),
            Text('Current Location', style: TextFontStyle.headline12StylePoppins,)
          ],
        ),


        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network('https:${weather.current?.condition?.icon}',),
            addHorizontalSpace(8.w),
            Text('Current Location', style: TextFontStyle.headline12StylePoppins,)
          ],
        )

      ],

    );
  }
}
