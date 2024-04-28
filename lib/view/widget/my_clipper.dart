import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {

  const MyClipper();

  @override
  Path getClip(Size size) {
    final path = Path();

    // Move to the desired point (x, y)
    path.moveTo(0, size.height*0.2);
    final halfWidth = size.width/2;
    path.quadraticBezierTo(0,0,halfWidth -halfWidth *0.2 , 0);
    path.arcToPoint(Offset(halfWidth + halfWidth *0.2, 0), radius: Radius.circular(30) , clockwise: false);
    path.quadraticBezierTo( size.width, 0, size.width , size.height*0.2 );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);


    // You can add other path commands here to define the shape
    // For example, a line to the bottom right corner:
    // path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}