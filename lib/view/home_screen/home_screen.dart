import 'package:daily_task_manager/controller/taskController.dart';
import 'package:daily_task_manager/helper/notification_helper.dart';
import 'package:daily_task_manager/model/add_task_model.dart';
import 'package:daily_task_manager/res/component/bottom_sheet_btns.dart';
import 'package:daily_task_manager/res/component/taskTile.dart';
import 'package:daily_task_manager/services/theme_services/theme_services.dart';
import 'package:daily_task_manager/view/home_screen/home_taskBar.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:daily_task_manager/res/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../services/notification_Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();

  TaskController taskController = Get.put(TaskController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService.initializeNotification();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initNotification();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () async{
            themeServices().switchTheme();
            await NotificationService.showNotification(
              title: "Title of the notification",
              body: "Body of the notification",
            );
            notifyHelper.displayNotification(
                title: "Theme Activated",
                body: Get.isDarkMode
                    ? "Dark Mode is Activated"
                    : "Light Mode is activated");
            // notifyHelper.scheduledNotification();
          },
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round_rounded,
            size: 30,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const CircleAvatar(
              backgroundImage: AssetImage("lib/res/assets/images/account.png"),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          const homeTaskBar(),
           DatePicker_Container(),
          const SizedBox(
            height: 20,
          ),
          _showTask(),
        ],
      ),
    );
  }
  _showTask() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (_, index) {
            TaskModel task=taskController.taskList[index];
            print(task.toJson());
            if(task.repeat=="Daily"){
              print(task.repeat);
              DateTime date=DateFormat.jm().parse(task.startTime.toString());
              var myTime=DateFormat('HH:MM').format(date);
              int hours = int.parse(myTime.toString().split(":")[0]);
              int minutes = int.parse(myTime.toString().split(":")[1]);

              final startTime = DateFormat.jm().parse(task.startTime.toString());
              NotificationService.showScheduledNotification(
              title: 'Scheduled notification',
              body: 'This notification is scheduled to appear at $startTime.',
              startTime: startTime,
              );

              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task,
              );
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ));
            }
            if(task.date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                  context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ));
            }else{
              return Container();
            }

          });
    }));
  }

  DatePicker_Container(){
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectionColor: appColor.primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });

        },
      ),
    );
  }
  _showBottomSheet(BuildContext context, TaskModel taskList) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 4),
      height: taskList.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? appColor.darkGreyClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          Spacer(),
          taskList.isCompleted == 1
              ? Container()
              : BottomSheetBtn.bottomSheetBtn(
                  lable: 'Task Completed',
                  onTap: () {
                    taskController.taskCompleted(taskList.id!);
                    Get.back();
                  },
                  clr: appColor.primaryClr,
                  context: context),
          const SizedBox(height: 10,),
          BottomSheetBtn.bottomSheetBtn(
              lable: 'Delete Task',
              onTap: () {
                taskController.delete(taskList);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context),
          SizedBox(height: 20,),
          BottomSheetBtn.bottomSheetBtn(
              lable: 'Close',
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
          isClose: true),
          SizedBox(height: 10,)
        ],
      ),
    ));
  }
}
