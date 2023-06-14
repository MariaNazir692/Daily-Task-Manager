import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notification_Detail extends StatelessWidget {
  final String? lable;
  const Notification_Detail({Key? key, required this.lable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.grey[600]:Colors.white,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        title: Text(this.lable.toString().split("|")[0]),
      ),

    );
  }
}
