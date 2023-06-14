import 'package:daily_task_manager/controller/taskController.dart';
import 'package:daily_task_manager/view/add_task_screen/add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../res/component/button.dart';
import '../../utils/utils.dart';

class homeTaskBar extends StatefulWidget {
  const homeTaskBar({Key? key}) : super(key: key);

  @override
  State<homeTaskBar> createState() => _homeTaskBarState();
}

class _homeTaskBarState extends State<homeTaskBar> {
  TaskController taskController=Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                    style: Utils.subHeadingStyle),
                Text(
                  "Today",
                  style: Utils.HeadingStyle,
                )
              ],
            ),
          ),
          appButton(
            text: "+Add Task",
            onPress: ()async{
              await Get.to(()=>addTaskPage());
              taskController.getTask();
              },
          )
        ],
      ),
    );
  }
}
