import 'package:flutter/material.dart';

class Mycustomcliper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - 20, 30, size.height - 30);
    path.lineTo(size.width - 30, size.height - 30);
    path.quadraticBezierTo(
      size.width,
      size.height - 25,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double curveHeight = size.height * 0.08;

    Path path = Path();
    path.lineTo(0, size.height - curveHeight);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - curveHeight,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - (curveHeight * 2),
      size.width,
      size.height - curveHeight,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
