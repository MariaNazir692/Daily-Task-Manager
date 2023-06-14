import 'package:daily_task_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetBtn{

  static bottomSheetBtn({
    required String lable,
    required Function() onTap,
    required Color clr,
    bool isClose=false,
    required BuildContext context
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
          ),
              borderRadius: BorderRadius.circular(20),
          color: isClose==true?Colors.transparent:clr,
        ),
        child: Center(child: Text(lable, style: isClose? Utils.formTitleStyle:Utils.formTitleStyle.copyWith(color: Colors.white),)),
      ),
    );

}
}