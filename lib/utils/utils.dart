import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:daily_task_manager/view/add_task_screen/add_task.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:daily_task_manager/res/color.dart';

import '../res/component/button.dart';

class Utils {
  static TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
  }

  static TextStyle get HeadingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }

  static TextStyle get formTitleStyle{
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Get.isDarkMode ? Colors.white : Colors.black));
  }
  static TextStyle get formsubTitleStyle{
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Get.isDarkMode ? Colors.grey[400]:Colors.black));
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(20),
          flushbarPosition: FlushbarPosition.TOP,
          reverseAnimationCurve: Curves.easeInOut,
          icon: Icon(Icons.error_outline,size: 30,color: Colors.white,),
          borderRadius: BorderRadius.circular(20),
          message: message,
          messageColor: Colors.white,
          backgroundColor: Colors.black45,
          duration: Duration(seconds: 5),
        )..show(context));
  }
}
