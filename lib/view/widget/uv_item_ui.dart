import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UvItemUi extends StatelessWidget {
  const UvItemUi({super.key});

  @override
  Widget build(BuildContext context) {
    return CoverDesign(child:  Row(
      children: [
        SizedBox(
          height: 56.h,
          width: 56.h,

        )
      ],
    ));
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
          child: child,
        ));
  }
}

