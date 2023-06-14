import 'package:daily_task_manager/res/color.dart';
import 'package:flutter/material.dart';

class appButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const appButton({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text, style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),),
      style: ElevatedButton.styleFrom(
          foregroundColor: appColor.primaryClr,
          shape: StadiumBorder(),
          fixedSize: Size(130, 50)),
    );
  }


}
