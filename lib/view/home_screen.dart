import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/degree/bloc/degree_bloc.dart';
import 'package:weather_sf_task/bloc/weather/weather_bloc_bloc.dart';
import 'package:weather_sf_task/component/custom_catch_image.dart';
import 'package:weather_sf_task/component/svg_show.dart';
import 'package:weather_sf_task/res/asset_names.dart';
import 'package:weather_sf_task/res/color.dart';
import 'package:weather_sf_task/res/constant.dart';
import 'package:weather_sf_task/res/date_parse.dart';
import 'package:weather_sf_task/res/text_font_style.dart';
import 'package:weather_sf_task/utils/helper_widget.dart';
import 'package:weather_sf_task/utils/icon_helper.dart';
import 'package:weather_sf_task/utils/url_helper.dart';
import 'package:weather_sf_task/utils/utils.dart';

import '../model/weather_parrent_model.dart';
import 'widget/bottom_ui.dart';
import 'widget/hour_item_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void getLocation(BuildContext context) async {
    determinePosition().then((position) =>
        context.read<WeatherBlocBloc>().add(FetchWeather(position)));
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
          gradient: LinearGradient(colors: [
            AppColor.secondaryColor,
            AppColor.primaryColor,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                      builder: (context, state) {
                        if (state is WeatherBlocLoading) {
                          return CircularProgressIndicator();
                        } else if (state is WeatherBlocFailure) {
                          return Text('Error ');
                        } else if (state is WeatherBlocSuccess) {
                          return ui(state.weather);
                        }
                        return Text('Initial');
                      },
                    ),
                  ],
                ),
              ),
            ),
            BottomUi()
          ],
        ),
      ),
    );
  }

  Widget ui(WeatherParentData weather) {
    // help me to find out actually the time is day or night
    final dayHelper = DayHelper(
        sunrise: weather.forecast?.forecastday?[0].astro?.sunrise ?? '',
        sunset: weather.forecast?.forecastday?[0].astro?.sunset ?? '');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dhaka',
          style: TextFontStyle.headline32StyleOpenSansBold,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgShow(path: AssetNames.locationIconSvg),
            addHorizontalSpace(8.w),
            Text(
              'Current Location',
              style: TextFontStyle.headline12StylePoppins,
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 135.sp,
                height: 135.sp,
                child: SvgShow(
                  path: IconHelper.getSvgIcon(
                      code: weather.current?.condition?.code ?? 1000,
                      isNight: dayHelper.isDayOrNight(
                          time: weather.current?.lastUpdated ?? '')),
                )
                // CustomCacheImageShow(
                //   imageUrl: UrlHelper.getImagePath(weather.current?.condition?.icon),
                // ),
                ),
            addHorizontalSpace(8.w),
            BlocBuilder<DegreeBloc, DegreeState>(builder: (context, state) {
              return Text(
                '${state is CentigradeState ? weather.current?.tempC : weather.current?.tempF} ${state is CentigradeState ? degreeCentigrade : degreeFahrenheit}',
                style: TextFontStyle.headline42StylePoppins,
              );
            })
          ],
        ),
        addVerticalSpace(20.sp),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${weather.current?.condition?.text} - Humidity',
              style: TextFontStyle.headline18StylePoppins,
            ),
            Text(
              ' ${weather.current?.humidity} %',
              style: TextFontStyle.headline12StylePoppins
                  .copyWith(color: Colors.lightGreen),
            ),
          ],
        ),
        addVerticalSpace(20.sp),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...forecastListUi(weather.forecast?.forecastday?[0].hour??[], dayHelper),
            ],
          ),
        ),

      ],
    );
  }

  List<Widget> forecastListUi(List<Hour> hours, DayHelper dayHelper){

    return hours.map((hour) =>
        HourItemUi(
            icon: IconHelper.getSvgIcon(
                code: hour.condition?.code ?? 1000,
                isNight: dayHelper.isDayOrNight(
                    time: hour.time ?? '')),
            hour: hour.time ?? '',
            tempC: hour.tempC ?? 0,
            tempF: hour.tempC ?? 0)).toList();
  }
}

