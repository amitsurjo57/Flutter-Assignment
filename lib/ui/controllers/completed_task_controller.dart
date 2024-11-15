import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class CompletedTaskController extends GetxController{

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

  String address = 'Completed';
  int _selectedIndex = 1;

  Future<bool> getCompletedTasks() async {
    try {
      _inProgress = true;
      taskList.clear();
      update();
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: NetworkUrls.tasksList(taskStatus: 'Completed'),
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
              statusColor: Colors.green,
              onEdit: () => _onEdit(task['_id'] ?? ''),
              onDelete: () => _deleteTask(task['_id'] ?? ''),
            ),
          );
          taskList.add(newTask);
          update();
        }
      } else {
        _snackBar(response.errorMessage);
      }
      return _isSuccess;
    } catch (e) {
      _snackBar(e.toString());
      return false;
    }
  }

  void _onEdit(String id) {
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
              _onEditConfirm(id);
              Get.back();
            },
            selected: _selectedIndex ==
                listOfEditOption.indexWhere((element) => element == e),
            selectedColor: Colors.green,
            selectedTileColor: Colors.green[100],
            title: Text(e),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _onEditConfirm(String id) async {
    try {
      await NetworkCaller.getRequest(
        url: NetworkUrls.updateTaskStatus(
          id: id,
          newStatus: listOfEditOption[_selectedIndex],
        ),
      );
      getCompletedTasks();
      _selectedIndex = 0;
      _taskStatusUpdateMessage = 'Task Status Updated to $address';
      _snackBar(_taskStatusUpdateMessage);
      update();
    } catch (e) {
      _taskStatusUpdateMessage = 'Something went wrong';
      _snackBar(_taskStatusUpdateMessage);
      _selectedIndex = 0;
      update();
    }
  }

  Future<void> _deleteTask(String id) async {
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      _snackBar('Task Deleted');
      getCompletedTasks();
    } catch (e) {
      _deleteTaskMessage = e.toString();
      _snackBar(_deleteTaskMessage);
    }
  }

  void _snackBar(String msg) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}