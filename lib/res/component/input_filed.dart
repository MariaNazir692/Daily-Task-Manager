import 'package:daily_task_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormInputFields extends StatelessWidget {

  final String text;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const FormInputFields({Key? key,
    required this.text,
    required this.hint,
    this.controller,
    this.widget


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: Utils.formTitleStyle,),
          Container(
            padding: EdgeInsets.only(left: 20),
            // color: Colors.grey,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor: Get.isDarkMode?Colors.black:Colors.grey[700],
                      controller: controller,
                      style: Utils.formsubTitleStyle,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: Utils.formsubTitleStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0
                          )
                        ),
                        enabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: context.theme.backgroundColor,
                                width: 0
                            )
                        ),
                      ),
                    )
                ),
                widget==null?Container():Container(child: widget,)
              ],
            )
          )
        ],
      ),
    );
  }
}
