import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/degree/degree_bloc.dart';
import 'package:weather_sf_task/bloc/forecast/forecast_bloc.dart';
import 'package:weather_sf_task/bloc/highlight_weather/highlight_weather_bloc.dart';
import 'package:weather_sf_task/component/svg_show.dart';
import 'package:weather_sf_task/model/network/weather_parrent_model.dart';
import 'package:weather_sf_task/res/asset_names.dart';
import 'package:weather_sf_task/res/constant.dart';
import 'package:weather_sf_task/res/text_font_style.dart';
import 'package:weather_sf_task/view/widget/my_clipper.dart';
import 'package:weather_sf_task/view/widget/uv_item_ui.dart';

class BottomUi extends StatelessWidget {
  final WeatherParentData? weatherParentData;
  const BottomUi({super.key,  this.weatherParentData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper:  const MyClipper(),
          child: Container(
            height: 270.h,
            width: double.maxFinite,
           decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white38, Colors.white10]
             )
           ),
          ),
        ),
        if(weatherParentData!=null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<HighlightWeatherBloc, HighlightWeatherState>(   /// this is handeling current and hour forecast with now
                  /// time like sometime user may be update yesterday but then current will be past value,
                  /// because current actually the data from net when he fetch first time so we carefully handle now
                  /// time and every hour to consider the past value, if internet not available and get data from Hive (DateParse)
                  builder: (context, state) {
                    final  hourNow = state is HighLightWeatherChangedState ? state.hourNow : null;
                    return UvItemUi(uv: '${hourNow==null? weatherParentData?.current?.uv : hourNow.current!=null? hourNow.current?.uv : hourNow.hour.uv}',);
                  }
                ),
                SizedBox(height: 6.h,),
                BlocBuilder<ForecastBloc, ForecastState>(
                  builder: (context, state) {
                    /// actually forecast change the day when you select so we just hold a index and this
                    /// individually day we gonna show here
                    final index = state is ForecastChangedState ? state.changeIndex : 0;
                    return SunRiseSunSetUi(sunRise: '${weatherParentData?.forecast?.forecastday?[index].astro?.sunrise}',
                    sunSet: '${weatherParentData?.forecast?.forecastday?[index].astro?.sunset}', );
                  }
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          ),
        Positioned(
          top: 0,
            child: GestureDetector(
                onTap: () => context.read<DegreeBloc>().state is CentigradeState
                    ? context.read<DegreeBloc>().add(FahrenheitEvent())
                    : context.read<DegreeBloc>().add(CentigradeEvent()),
                child: const SwitchUi())),
      ],
    );
  }
}

class SwitchUi extends StatelessWidget {
  const SwitchUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
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
              height: 40.w,
              width: 40.w,
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
            )),
        BlocBuilder<DegreeBloc, DegreeState>(builder: (context, state) {
          return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: state is CentigradeState ? 0 : 40,
              child: const SvgShow(path: AssetNames.switchIconSvg));
        }),
        BlocBuilder<DegreeBloc, DegreeState>(builder: (context, state) {
          return state is CentigradeState?  const Text(degreeCentigrade,): const Text(degreeFahrenheit);
        })
      ],
    );
  }
}
