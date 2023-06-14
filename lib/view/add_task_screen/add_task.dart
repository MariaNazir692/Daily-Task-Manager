import 'package:daily_task_manager/controller/taskController.dart';
import 'package:daily_task_manager/model/add_task_model.dart';
import 'package:daily_task_manager/res/component/button.dart';
import 'package:daily_task_manager/res/component/input_filed.dart';
import 'package:daily_task_manager/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:daily_task_manager/res/color.dart';

class addTaskPage extends StatefulWidget {
  const addTaskPage({Key? key}) : super(key: key);

  @override
  State<addTaskPage> createState() => _addTaskPageState();
}

class _addTaskPageState extends State<addTaskPage> {

  TaskController taskController=Get.put(TaskController());
int selectedColor=0;

  TextEditingController titileController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = "09:30 PM";

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
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
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: Utils.HeadingStyle,
              ),
              FormInputFields(
                text: "Title",
                hint: "Enter Your title here",
                controller: titileController,
              ),
              FormInputFields(
                text: "Note",
                hint: "Enter Your note here",
                controller: noteController,
              ),
              FormInputFields(
                text: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: FormInputFields(
                      text: "Start Date",
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUSer(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: FormInputFields(
                      text: "End Date",
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUSer(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              ),
              FormInputFields(
                  text: "Remind",
                  hint: "$_selectedRemind minutes early",
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey),
                    iconSize: 30,
                    elevation: 4,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()));
                    }).toList(),
                  )),
              FormInputFields(
                  text: "Repeat",
                  hint: _selectedRepeat,
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down_sharp,
                        color: Colors.grey),
                    iconSize: 30,
                    elevation: 4,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.grey),
                          ));
                    }).toList(),
                  )),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   colorPallet(),
                  appButton(
                      text: 'Create Task',
                      onPress: () {
                        _validateData();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (titileController.text.isNotEmpty && noteController.text.isNotEmpty) {
      _addTasktoDB();
      //store in DB
      Get.back();
    } else if (titileController.text.isEmpty || noteController.text.isEmpty) {
      Utils.flushBarErrorMessage('All Fields are required', context);
    }
  }

  colorPallet(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Utils.formTitleStyle,
        ),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                   selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? appColor.primaryClr
                      : index == 1
                      ? appColor.pinkClr
                      : appColor.yellowClr,
                  child: selectedColor==index?Icon(Icons.done, color: Colors.white,size: 16, ):Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  //this
  _addTasktoDB()async{
    //this add task will call insert function that will return the id of that user so we have to store that id
    int value=await taskController.addTask(
        task:TaskModel(
            title: titileController.text,
            note: noteController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: selectedColor,
            isCompleted: 0
        )
    );
    print(value);

  }

  _getDateFromUser() async {
    DateTime? _picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030));
    if (_picker != null) {
      setState(() {
        _selectedDate = _picker;
      });
    } else {
      if (kDebugMode) {
        print('error');
      }
    }
  }

  _getTimeFromUSer({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    String _formatedTime = _pickedTime.format(context);
    if (_pickedTime == null) {
      if (kDebugMode) {
        print('time not selected');
      }
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(" ")[0])));
  }
}
