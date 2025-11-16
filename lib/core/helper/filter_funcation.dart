import 'package:flutter/material.dart';

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case "red":
      return Colors.red;
    case "blue":
      return Colors.blue;
    case "black":
      return Colors.black;
    case "white":
      return Colors.white;
    case "green":
      return Colors.green;
    case "yellow":
      return Colors.yellow;
    case "gold":
      return Color(0xFFFFD700); // Gold
    case "silver":
      return Color(0xFFC0C0C0); // Silver
    case "purple":
      return Colors.purple;
    case "orange":
      return Colors.orange;
    case "pink":
      return Colors.pink;
    case "brown":
      return Colors.brown;

    default:
      return Colors.grey; // لو مش لاقي اللون
  }
}
