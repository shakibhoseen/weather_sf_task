import 'dart:developer';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/degree/degree_bloc.dart';
import 'package:weather_sf_task/bloc/forecast/forecast_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';
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
import 'package:weather_sf_task/view/widget/day_selection_ui.dart';
import 'package:weather_sf_task/view/widget/list_hour_item_ui.dart';

import '../model/weather_parrent_model.dart';
import '../res/net_conectivity.dart';
import 'widget/bottom_ui.dart';
import 'widget/highlight_weather_title.dart';
import 'widget/hour_item_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedWeatherItemIndex = 0, selectedDayIndex = 0;
  String lastUpdated = '';
  late ForecastBloc forecastBloc;
  late HighlightWeatherBloc highlightWeatherBloc;
  List<Forecastday>? forecastDayList;

  void getLocation(BuildContext context) async {
   bool?  connected = await NetConnectivity().checkInternet(context);

    determinePosition().then((position) =>
        context.read<WeatherBlocBloc>().add(FetchWeather(position, connected?? false)));
    //listenerForDataSource(context.read<WeatherBlocBloc>(), );
  }

  @override
  void initState() {
    forecastBloc = context.read<ForecastBloc>();
    highlightWeatherBloc = context.read<HighlightWeatherBloc>();
    super.initState();
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
                          //state.isCurrent ;
                          forecastDayList = state.weather.forecast?.forecastday;
                          //var hour = Hour
                          return mainUi();
                        }
                        return Text('Initial');
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
              WeatherParentData? data;
              if (state is WeatherBlocSuccess) {
                data = state.weather;
              }
              return BottomUi(
                weatherParentData: data,
              );
            })
          ],
        ),
      ),
    );
  }

  Widget mainUi() {
    // help me to find out actually the time is day or night


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
        BlocBuilder<HighlightWeatherBloc, HighlightWeatherState>(
            builder: (context, state) {
          if (state is HighLightWeatherChangedState) {
            final maxMin = MaxMinCFHolder(
                tempC: state.hour.tempC,
                tempF: state.hour.tempF,
                mxTempC: forecastDayList?[selectedDayIndex].day?.maxtempC,
                mxTempF: forecastDayList?[selectedDayIndex].day?.maxtempF,
                minTempC: forecastDayList?[selectedDayIndex].day?.mintempC,
                minTempF: forecastDayList?[selectedDayIndex].day?.mintempF);
            return HighlightWeatherTitle(
              maxMinCF: maxMin,
              condition: state.hour.condition,
            );
          }
          return const SizedBox.shrink();
        }),
        addVerticalSpace(20.sp),
        Builder(
          builder: (context) {
            final titleList = forecastDayList?.map((e) => e.date ??'empty').toList();
            return DaySelectionUi(titleDate:  titleList??[], onChangedIndex: ( index) {
               selectedDayIndex = index;
               forecastBloc.add(ForecastChangedEvent(changeIndex:  selectedDayIndex));
            },);
          }
        ),
        addVerticalSpace(20.sp),
        BlocBuilder<ForecastBloc, ForecastState>(
          builder: (context, state) {
            final dayHelper = DayHelper(
                sunrise: forecastDayList?[selectedDayIndex].astro?.sunrise ?? '',
                sunset: forecastDayList?[selectedDayIndex].astro?.sunset ?? '');
            return ListHourItemUi(hours: forecastDayList?[selectedDayIndex].hour ?? [], dayHelper: dayHelper);
          }
        ),
      ],
    );
  }


}
