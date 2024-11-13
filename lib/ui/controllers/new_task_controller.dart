import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/main.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class NewTaskController extends GetxController {
  bool _inProgress = false;
  bool _isSuccess = false;
  String? _errorMessage;
  String _taskStatusUpdateMessage = '';
  String _deleteTaskMessage = ' ';
  final List<TaskWidget> _taskList = [];

  List<TaskWidget> get taskList => _taskList;

  bool get isSuccess => _isSuccess;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  String get taskStatusUpdateMessage => _taskStatusUpdateMessage;

  String get deleteTaskMessage => _deleteTaskMessage;

  List<String> listOfEditOption = [
    'New',
    'Completed',
    'Canceled',
    'Progress',
  ];

  String address = 'New';
  int _selectedIndex = 0;

  Future<bool> getNewTasks() async {
    try {
      _inProgress = true;
      taskList.clear();
      update();
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: NetworkUrls.tasksList(taskStatus: 'New'),
      );

      if (response.isSuccess) {
        _inProgress = false;
        _isSuccess = true;
        update();
        Map<String, dynamic> newTaskResponse = response.responseData;

        for (var task in newTaskResponse['data']) {
          TaskWidget newTask = TaskWidget(
            taskModel: TaskModel(
              title: task['title'] ?? '',
              subTitle: task['description'] ?? '',
              date: task['createdDate'] ?? '',
              status: task['status'] ?? '',
              statusColor: Colors.blue,
              onEdit: () => _onTapEdit(task['_id'] ?? ''),
              onDelete: () => _deleteTask(task['_id'] ?? ''),
            ),
          );
          _taskList.add(newTask);
          update();
        }
      } else {
        _errorMessage = "Something went wrong";
      }
      return isSuccess;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void _onTapEdit(String id) {
    Get.defaultDialog(
      title: 'Edit Status',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: listOfEditOption.map((e) {
          return ListTile(
            onTap: () {
              _selectedIndex =
                  listOfEditOption.indexWhere((element) => element == e);
              address = e;
              update();
            },
            selected: _selectedIndex ==
                listOfEditOption.indexWhere((element) => element == e),
            selectedColor: Colors.green,
            selectedTileColor: Colors.green[100],
            title: Text(e),
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => _onTapEditOkayOption(id),
          child: const Text('Ok'),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Future<void> _deleteTask(String id) async {
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text("Task Deleted"),
        ),
      );
      update();
    } catch (e) {
      _deleteTaskMessage = e.toString();
    }
  }

  Future<void> _onTapEditOkayOption(String id) async {
    try {
      await NetworkCaller.getRequest(
        url: NetworkUrls.updateTaskStatus(
          id: id,
          newStatus: listOfEditOption[_selectedIndex],
        ),
      );
      getNewTasks();
      Navigator.pop(MyApp.navigatorKey.currentContext!);
      _taskStatusUpdateMessage = 'Task Status Updated to $address';
      update();
    } catch (e) {
      _taskStatusUpdateMessage = 'Something went wrong';
    }
  }
}
