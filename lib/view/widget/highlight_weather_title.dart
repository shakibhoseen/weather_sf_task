import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/model/weather_parrent_model.dart';

import '../../bloc/degree/degree_bloc.dart';
import '../../component/svg_show.dart';
import '../../res/constant.dart';
import '../../res/text_font_style.dart';
import '../../utils/helper_widget.dart';
import '../../utils/icon_helper.dart';

class HighlightWeatherTitle extends StatelessWidget {
  final Condition? condition;
  final bool isNight; // dayHelper.isDayOrNight(time: lastUpdated ?? '')

  final MaxMinCFHolder maxMinCF;

  const HighlightWeatherTitle(
      {super.key, this.condition, this.isNight = false,  required this.maxMinCF,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 135.sp,
                height: 135.sp,
                child: SvgShow(
                  path: IconHelper.getSvgIcon(
                      code: condition?.code ?? 1000,
                      isNight: isNight),
                )
              // CustomCacheImageShow(
              //   imageUrl: UrlHelper.getImagePath(weather.current?.condition?.icon),
              // ),
            ),
            addHorizontalSpace(8.w),
            BlocBuilder<DegreeBloc, DegreeState>(builder: (context, state) {
              return Text(
                '${state is CentigradeState ?  maxMinCF.tempC : maxMinCF.tempF} ${state is CentigradeState
                    ? degreeCentigrade
                    : degreeFahrenheit}',
                style: TextFontStyle.headline42StylePoppins,
              );
            })
          ],
        ),

        addVerticalSpace(20.sp),
        BlocBuilder<DegreeBloc, DegreeState>(
          builder: (context, degree) {
            return Text(
              '${condition?.text} - H:${getTemp(tempC: maxMinCF.mxTempC, tempF: maxMinCF.mxTempF, isCentigrade: degree is CentigradeState)} - L'
              ':${getTemp(tempC: maxMinCF.minTempC, tempF: maxMinCF.minTempF, isCentigrade: degree is CentigradeState)}',
              style: TextFontStyle.headline18StylePoppins,
            );
          }
        ),
      ],
    );
  }
  double? getTemp({required double? tempC, required double? tempF, bool isCentigrade = true}){
     return isCentigrade? tempC : tempF;
  }
}

class MaxMinCFHolder{
  final double? tempC, tempF, mxTempC, mxTempF, minTempC, minTempF;

  MaxMinCFHolder(
      {required this.tempC,
      required this.tempF,
      required this.mxTempC,
      required this.mxTempF,
      required this.minTempC,
      required this.minTempF});
}

