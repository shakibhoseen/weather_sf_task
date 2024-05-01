import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/forecast/forecast_bloc.dart';
import 'package:weather_sf_task/res/text_font_style.dart';

class DaySelectionUi extends StatelessWidget {
  final List<String> titleDate;
  final Function(int index) onChangedIndex;
  const DaySelectionUi({super.key, required this.titleDate, required this.onChangedIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: titleDate.mapIndexed((index, element) => GestureDetector(
          onTap: ()=>onChangedIndex.call(index),
            child: _SelectUi(isSelect: false, title: element))).toList(),
      ),
    );
  }
}

class _SelectUi extends StatelessWidget {
  final bool isSelect;
  final String title;
  const _SelectUi({super.key, required this.isSelect, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
      decoration: BoxDecoration(
          color: isSelect? Colors.white10 : Colors.black12,
          borderRadius: BorderRadius.circular(25.r)
      ),
      child: Text(title, style: TextFontStyle.headline16StyleInter.copyWith(fontSize: 14.sp),),
    );
  }
}




