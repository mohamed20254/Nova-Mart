import 'package:flutter/material.dart';

class AppSize {
  AppSize._();
  static hight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static spacehight1(context) => AppSize.hight(context) * 0.01;
  static spacehight2(context) => AppSize.hight(context) * 0.02;
  static spacehight3(context) => AppSize.hight(context) * 0.03;
  static spacehight4(context) => AppSize.hight(context) * 0.04;

  static spacewWidth1(context) => AppSize.width(context) * 0.01;
  static spacewWidth2(context) => AppSize.width(context) * 0.02;
  static spacewWidth3(context) => AppSize.width(context) * 0.03;
  static spacewWidth4(context) => AppSize.width(context) * 0.04;
}
