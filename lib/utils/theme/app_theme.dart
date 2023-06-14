
import 'package:flutter/material.dart';
import 'package:daily_task_manager/res/color.dart';
class appTheme{
static final light=ThemeData(
  backgroundColor: Colors.white,
  primaryColor: appColor.primaryClr,
  brightness: Brightness.light
);
static final dark=ThemeData(
  backgroundColor: appColor.darkGreyClr,
  primaryColor: appColor.darkGreyClr,
  brightness: Brightness.dark
);

}