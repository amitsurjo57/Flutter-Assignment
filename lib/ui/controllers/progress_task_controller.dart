import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class ProgressTaskController extends GetxController{
  bool _inProgress = false;
  bool _isSuccess = false;
  String? _errorMessage;
  final List<TaskWidget> _taskList = [];

  List<TaskWidget> get taskList => _taskList;

  bool get isSuccess => _isSuccess;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  List<String> listOfEditOption = [
    'New',
    'Completed',
    'Canceled',
    'Progress',
  ];

  String address = 'Progress';
  int _selectedIndex = 3;

  Future<bool> getProgressTasks() async {
    try {
      _inProgress = true;
      taskList.clear();
      update();
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: NetworkUrls.tasksList(taskStatus: 'Progress'),
      );

      if (response.isSuccess) {
        _inProgress = false;
        _isSuccess = true;
        update();
        Map<String, dynamic> newTaskResponse = response.responseData;

        for (var task in newTaskResponse['data']) {
          update();

          TaskWidget newTask = TaskWidget(
            taskModel: TaskModel(
              title: task['title'] ?? '',
              subTitle: task['description'] ?? '',
              date: task['createdDate'] ?? '',
              status: task['status'] ?? '',
              statusColor: Colors.purple,
              onEdit: () => _onEdit(task['_id'] ?? ''),
              onDelete: () => _deleteTask(task['_id'] ?? ''),
            ),
          );
          taskList.add(newTask);
        }
      } else {
        _errorMessage = response.errorMessage;
      }
      return _isSuccess;
    } catch (e) {
      _errorMessage = e.toString();
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
      getProgressTasks();
      _selectedIndex = 3;
      mySnackBar('Task Status Updated to $address');
      update();
    } catch (e) {
      mySnackBar('Something went wrong');
      _selectedIndex = 3;
      update();
    }
  }

  Future<void> _deleteTask(String id) async {
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      mySnackBar('Task Deleted');
      getProgressTasks();
    } catch (e) {
      mySnackBar(e.toString());
    }
  }
}