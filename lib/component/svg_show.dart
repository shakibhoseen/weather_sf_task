import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgShow extends StatelessWidget {
  final String path;
  const SvgShow({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path);
  }
}
