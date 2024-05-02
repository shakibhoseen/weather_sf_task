import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/component/svg_show.dart';

import '../../bloc/degree/degree_bloc.dart';
import '../../res/constant.dart';
import '../../res/date_parse.dart';
import '../../res/text_font_style.dart';

class HourItemUi extends StatelessWidget {
  final String icon, hour;
  final double tempC, tempF;
  final bool isSelected;

  const HourItemUi(
      {super.key,
      required this.icon,
      required this.hour,
      required this.tempC,
      required this.tempF,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.all(6.w),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.26, -0.97),
              end: const Alignment(-0.26, 0.97),
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.2),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          padding: EdgeInsets.all(4.w),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.26, -0.97),
                end: const Alignment(-0.26, 0.97),
                colors: [
                  Colors.white.withOpacity(0.1),
                  const Color(0xff627BD0),
                  //Colors.white.withOpacity(0.0),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    hour.toLowerCase() == 'now'
                        ? hour
                        : DateParse.getHourWithAm(hour),
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline16StyleInter),
                 SizedBox(height: 8.h),
                SizedBox(
                  height: 48.w,
                  width: 48.w,
                  child: SvgShow(
                    path: icon,
                  ), //CustomCacheImageShow(imageUrl: UrlHelper.getImagePath(icon) ,),
                ),
                 SizedBox(height: 8.h),
                BlocBuilder<DegreeBloc, DegreeState>(builder: (context, state) {
                  return Text(
                      '${state is CentigradeState ? tempC : tempF} ${state is CentigradeState ? degreeCentigrade : degreeFahrenheit}',
                      textAlign: TextAlign.center,
                      style: TextFontStyle.headline12StylePoppins);
                }),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.sp,),
        if(isSelected)
        Container(
          height: 10.sp,
          width: 10.sp,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        )
      ],
    );
  }
}
