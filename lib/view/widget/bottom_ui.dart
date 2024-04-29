import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_sf_task/bloc/degree/bloc/degree_bloc.dart';
import 'package:weather_sf_task/component/svg_show.dart';
import 'package:weather_sf_task/res/asset_names.dart';
import 'package:weather_sf_task/res/constant.dart';
import 'package:weather_sf_task/res/text_font_style.dart';
import 'package:weather_sf_task/view/widget/my_clipper.dart';

class BottomUi extends StatelessWidget {
  const BottomUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
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
        Positioned(
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
