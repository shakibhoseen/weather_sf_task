import 'package:flutter/material.dart';
import 'package:weather_sf_task/view/widget/my_clipper.dart';

class BottomUi extends StatelessWidget {
  const BottomUi({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: 300,
        width: double.maxFinite,
        color: Colors.yellow,
      ),
    );
  }
}
