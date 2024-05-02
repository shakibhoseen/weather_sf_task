import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';
import 'package:weather_sf_task/bloc/hour_index/index_bloc.dart';

import '../../model/local/hour_current_combine.dart';
import '../../res/date_parse.dart';
import '../../utils/icon_helper.dart';
import 'hour_item_ui.dart';

class ListHourItemUi extends StatelessWidget {
  final List<HourAndNowCombine> hours;
  final DayHelper dayHelper;
  final IndexBloc indexBloc;
   ListHourItemUi(
      {super.key, required this.hours, required this.dayHelper}): indexBloc = IndexBloc();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<IndexBloc, IndexState>(
        bloc: indexBloc,
        builder: (context, state) {
          return Row(
            children: [
              ...forecastListUi(context , state is IndexChangedState ? state.changeIndex : null),
            ],
          );
        }
      ),
    );
  }

  List<Widget> forecastListUi(BuildContext context, int? selectedIndex) {
    return hours
        .mapIndexed((index, hourNow) {
          final flag = hourNow.current!= null ? DateParse.isTakeFromCurrent(hour: hourNow.hour.time, current: hourNow.current?.lastUpdated) : false;
      return GestureDetector(
        onTap: () {
          context.read<HighlightWeatherBloc>().add(
              HighLightWeatherChangedEvent(hourNow));
          indexBloc.add(IndexChangedEvent(changeIndex: index));
        },
        child: HourItemUi(
          isSelected: selectedIndex!=null? selectedIndex==index: false ,
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
