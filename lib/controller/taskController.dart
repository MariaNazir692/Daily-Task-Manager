
import 'package:daily_task_manager/helper/db_helper.dart';
import 'package:daily_task_manager/model/add_task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  var taskList=<TaskModel>[].obs;

  Future<int> addTask({TaskModel? task})async{
    return await DBHelper.insert(task);
  }

  void getTask()async{
    List<Map<String, dynamic>> tasks=await DBHelper.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel task){
  DBHelper.delete(task);
    getTask();
  }

  void taskCompleted(int id)async{
    await DBHelper.update(id);
    getTask();
  }
}