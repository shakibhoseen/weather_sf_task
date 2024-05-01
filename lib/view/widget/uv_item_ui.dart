import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/component/svg_show.dart';
import 'package:weather_sf_task/res/text_font_style.dart';

import '../../res/asset_names.dart';

class UvItemUi extends StatelessWidget {
  final String uv;
  const UvItemUi({super.key, required this.uv});

  @override
  Widget build(BuildContext context) {

    return CoverDesign(child:  Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.h,
          child: const SvgShow(path: AssetNames.uvIndexIconSvg,),
        ),
        titleTimeUi('UV Index', uv),
        const SizedBox(),
        const SizedBox(),

      ],
    ));
  }
  
  
  Widget titleTimeUi(String title, String value){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         Text(title, style: TextFontStyle.headline16StyleInter,),
         Text(value, style: TextFontStyle.headline22StylePoppins.copyWith(fontWeight: FontWeight.w700),),

      ],
    );
  }
}

class SunRiseSunSetUi extends StatelessWidget {
  final String sunRise, sunSet;
  const SunRiseSunSetUi({super.key, required this.sunRise, required this.sunSet});

  @override
  Widget build(BuildContext context) {
    return CoverDesign(child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.h,
          child: const SvgShow(path: AssetNames.sunRiseIconSvg,),
        ),
        titleTimeUi('Sunrise',sunRise),
        titleTimeUi('Sunset',sunSet),
      ],
    ));
  }


  Widget titleTimeUi(String title, String value){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: TextFontStyle.headline16StyleInter,),
        Text(value, style: TextFontStyle.headline22StylePoppins.copyWith(fontWeight: FontWeight.w700),),

      ],
    );
  }
}


class CoverDesign extends StatelessWidget {
  final Widget child;
  const CoverDesign({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.symmetric( vertical: 2),
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
          child: child,
        ));
  }
}

