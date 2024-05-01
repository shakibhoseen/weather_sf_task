import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/component/svg_show.dart';

import '../../bloc/degree/degree_bloc.dart';
import '../../component/custom_catch_image.dart';
import '../../res/constant.dart';
import '../../res/date_parse.dart';
import '../../res/text_font_style.dart';
import '../../utils/url_helper.dart';

class HourItemUi extends StatelessWidget {
  final String icon, hour;
  final double tempC, tempF;
  const HourItemUi({super.key,  required this.icon,
    required this.hour,
    required this.tempC,
    required this.tempF});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                DateParse.getHourWithAm(hour),
                textAlign: TextAlign.center,
                style: TextFontStyle.headline16StyleInter
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 48.w,
              width: 48.w,
              child: SvgShow(path: icon,), //CustomCacheImageShow(imageUrl: UrlHelper.getImagePath(icon) ,),
            ),
            const SizedBox(height: 8),
            BlocBuilder<DegreeBloc, DegreeState>(
                builder: (context, state) {
                  return  Text(
                      '${state is CentigradeState ? tempC : tempF} ${state is CentigradeState ? degreeCentigrade : degreeFahrenheit}',
                      textAlign: TextAlign.center,
                      style: TextFontStyle.headline12StylePoppins
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

