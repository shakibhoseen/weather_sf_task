import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';

import '../../model/local/hour_current_combine.dart';
import '../../res/date_parse.dart';
import '../../utils/icon_helper.dart';
import 'hour_item_ui.dart';

class ListHourItemUi extends StatelessWidget {
  final List<HourAndNowCombine> hours;
  final DayHelper dayHelper;

  const ListHourItemUi(
      {super.key, required this.hours, required this.dayHelper});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...forecastListUi(context),
        ],
      ),
    );
  }

  List<Widget> forecastListUi(BuildContext context) {
    return hours
        .mapIndexed((index, hourNow) {
          final flag = hourNow.current!= null ? DateParse.isTakeFromCurrent(hour: hourNow.hour.time, current: hourNow.current?.lastUpdated) : false;
      return GestureDetector(
        onTap: () {
          context.read<HighlightWeatherBloc>().add(
              HighLightWeatherChangedEvent(hourNow));
        },
        child: HourItemUi(
            icon: IconHelper.getSvgIcon(
                code: flag ? hourNow.current?.condition?.code ?? 1000: hourNow.hour.condition?.code  ?? 1000,
                isNight: dayHelper.isDayOrNight(time: flag ? hourNow.current?.lastUpdated ??'' : hourNow.hour.time ?? '')),
            hour: hourNow.current==null ? hourNow.hour.time??'' : 'Now',//DateParse.convertNowToHourMinute(),
            tempC: flag ? hourNow.current?.tempC ?? 0:hourNow.hour.tempC ?? 0,
            tempF: flag ? hourNow.current?.tempF ?? 0:hourNow.hour.tempF ?? 0,),
      );
    }
    )
        .toList();
  }
}