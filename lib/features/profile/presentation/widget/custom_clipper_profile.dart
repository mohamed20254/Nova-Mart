import 'package:flutter/material.dart';

class CustomClipperProfile extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - 8, 20, size.height - 13);
    path.lineTo(size.width - 20, size.height - 13);
    path.quadraticBezierTo(
      size.width,
      size.height - 8,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
