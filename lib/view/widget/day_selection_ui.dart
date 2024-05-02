import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/forecast/forecast_bloc.dart';
import 'package:weather_sf_task/res/text_font_style.dart';

import '../../res/date_parse.dart';

class DaySelectionUi extends StatelessWidget {
  final List<String> titleDate;
  final Function(int index) onChangedIndex;

  const DaySelectionUi(
      {super.key, required this.titleDate, required this.onChangedIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: titleDate
                  .mapIndexed(
                    (index, element) => GestureDetector(
                      onTap: () => onChangedIndex.call(index),
                      child: _SelectUi(
                          isSelect: state is ForecastChangedState
                              ? index == state.changeIndex
                              : index == 0,
                          title: element),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class _SelectUi extends StatelessWidget {
  final bool isSelect;
  final String title;

  const _SelectUi({required this.isSelect, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 22.w),
      decoration: BoxDecoration(
          color: isSelect ? Colors.white10 : Colors.black12,
          borderRadius: BorderRadius.circular(25.r)),
      child: Text(
          DateParse.convertTodayYesterday(title),
        style: TextFontStyle.headline16StyleInter.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
