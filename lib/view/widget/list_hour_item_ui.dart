import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
  final int? nowPosition;  // why is now position , you notice now Content actually already inserted to that
  // list but i want to animate only for now every time
  final ItemScrollController itemScrollController = ItemScrollController();

  ListHourItemUi({super.key, required this.hours, required this.dayHelper,  this.nowPosition})
      : indexBloc = IndexBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, IndexState>(
        bloc: indexBloc,
        builder: (context, state) {
          return SizedBox(
              height: 200,
              child: scrollList(state is IndexChangedState
                  ? state.changeIndex
                  : nowPosition));

          //   Row(
          //   children: [
          //     ...forecastListUi(context , state is IndexChangedState ? state.changeIndex : null),
          //   ],
          // );
        });
  }

  Widget scrollList(int? selectedIndex) {
     if(selectedIndex!=null){
       callFuture(selectedIndex);
     }

    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: hours.length,
      itemBuilder: (context, index) {
        if (index < 0 || index >= hours.length) {
          // actually this package sometime gives -1 index , and this is funny
          return const SizedBox
              .shrink(); // Return an empty widget if index is out of bounds
        }
        final hourNow = hours[index];
        final flag = hourNow.current != null
            ? DateParse.isTakeFromCurrent(
                hour: hourNow.hour.time, current: hourNow.current?.lastUpdated)
            : false;
        return GestureDetector(
          onTap: () {
            context
                .read<HighlightWeatherBloc>()
                .add(HighLightWeatherChangedEvent(hourNow));
            indexBloc.add(IndexChangedEvent(changeIndex: index));
          },
          child: HourItemUi(
            isSelected: selectedIndex != null ? selectedIndex == index : false,
            icon: IconHelper.getSvgIcon(
                code: flag
                    ? hourNow.current?.condition?.code ?? 1000
                    : hourNow.hour.condition?.code ?? 1000,
                isNight: dayHelper.isDayOrNight(
                    time: flag
                        ? hourNow.current?.lastUpdated ?? ''
                        : hourNow.hour.time ?? '')),
            hour: hourNow.current == null ? hourNow.hour.time ?? '' : 'Now',
            //DateParse.convertNowToHourMinute(),
            tempC: flag ? hourNow.current?.tempC ?? 0 : hourNow.hour.tempC ?? 0,
            tempF: flag ? hourNow.current?.tempF ?? 0 : hourNow.hour.tempF ?? 0,
          ),
        );
      },
    );
  }

  void callFuture(int selectIndex) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        changeIndexScroll(selectIndex);
      });
    });
  }

  void changeIndexScroll(int index) {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }
}
