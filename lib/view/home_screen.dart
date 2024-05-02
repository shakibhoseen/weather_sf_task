
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/forecast/forecast_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';
import 'package:weather_sf_task/bloc/weather/weather_bloc_bloc.dart';
import 'package:weather_sf_task/component/svg_show.dart';
import 'package:weather_sf_task/res/asset_names.dart';
import 'package:weather_sf_task/res/color.dart';
import 'package:weather_sf_task/res/date_parse.dart';
import 'package:weather_sf_task/res/text_font_style.dart';
import 'package:weather_sf_task/utils/helper_widget.dart';
import 'package:weather_sf_task/utils/utils.dart';
import 'package:weather_sf_task/view/widget/day_selection_ui.dart';
import 'package:weather_sf_task/view/widget/list_hour_item_ui.dart';

import '../model/local/hour_current_combine.dart';
import '../model/network/weather_parrent_model.dart';
import '../res/net_conectivity.dart';
import 'widget/bottom_ui.dart';
import 'widget/highlight_weather_title.dart';

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
  Current? current;

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
                          return const CircularProgressIndicator();
                        } else if (state is WeatherBlocFailure) {
                          return const Text('Error ');
                        } else if (state is WeatherBlocSuccess) {
                          //state.isCurrent ;
                          forecastDayList = state.weather.forecast?.forecastday;
                          current = state.weather.current;
                          highlightWeatherBloc.add(HighLightWeatherChangedEvent(HourAndNowCombine(hour: forecastDayList![selectedDayIndex].hour![0], current: current)));
                          //var hour = Hour
                          return mainUi();
                        }
                        return const Text('Initial');
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
          style: TextFontStyle.headline30StyleOpenSansBold,
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
            final flag = state.hourNow.current!= null ? DateParse.isTakeFromCurrent(hour: state.hourNow.hour.time, current: state.hourNow.current?.lastUpdated) : false;
            final maxMin = MaxMinCFHolder(
                tempC: flag ? state.hourNow.current?.tempC : state.hourNow.hour.tempC,
                tempF: flag ? state.hourNow.current?.tempF : state.hourNow.hour.tempF,
                mxTempC: forecastDayList?[selectedDayIndex].day?.maxtempC,
                mxTempF: forecastDayList?[selectedDayIndex].day?.maxtempF,
                minTempC: forecastDayList?[selectedDayIndex].day?.mintempC,
                minTempF: forecastDayList?[selectedDayIndex].day?.mintempF);
            return HighlightWeatherTitle(
              maxMinCF: maxMin,
              condition: flag ? state.hourNow.current?.condition : state.hourNow.hour.condition,
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
            final p = forecastDayList?[selectedDayIndex].hour ?? [];
            final  indexWithList = DateParse.removePastHour(p, p[0].time!); // removed past hours
            final List<HourAndNowCombine> added = createList(indexWithList); // add current if need
            return ListHourItemUi(hours: added, dayHelper: dayHelper);
          }
        ),
      ],
    );
  }

   List<HourAndNowCombine> createList((List<Hour>, int) value,){
       if(value.$2<0){
         return value.$1.map((e) => HourAndNowCombine(hour: e)).toList();
       }
       return value.$1.mapIndexed((index, element) => HourAndNowCombine(hour: element, current: index == 0? current : null)).toList();
   }
}

