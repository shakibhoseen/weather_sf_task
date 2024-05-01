import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';

import '../../model/weather_parrent_model.dart';
import '../../res/date_parse.dart';
import '../../utils/icon_helper.dart';
import 'hour_item_ui.dart';

class ListHourItemUi extends StatelessWidget {
  final List<Hour> hours;
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
        .mapIndexed((index, hour) => GestureDetector(
              onTap: () {
                context.read<HighlightWeatherBloc>().add(HighLightWeatherChangedEvent(hour));
              },
              child: HourItemUi(
                  icon: IconHelper.getSvgIcon(
                      code: hour.condition?.code ?? 1000,
                      isNight: dayHelper.isDayOrNight(time: hour.time ?? '')),
                  hour: hour.time ?? '',
                  tempC: hour.tempC ?? 0,
                  tempF: hour.tempF ?? 0),
            ))
        .toList();
  }
}
