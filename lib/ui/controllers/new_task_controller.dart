import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/Model/Main%20App/task_counter_model.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Main%20App/counting_card.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class NewTaskController extends GetxController {
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

  List<CountingCard> taskCounterList = [];

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
              onEdit: () => _onEdit(task['_id'] ?? ''),
              onDelete: () => _deleteTask(task['_id'] ?? ''),
            ),
          );
          _taskList.add(newTask);
          update();
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

  Future<void> getTaskCounter() async {
    try {
      NetworkResponse response =
          await NetworkCaller.getRequest(url: NetworkUrls.taskCounter);
      if (response.isSuccess) {
        taskCounterList.clear();
        update();
        Map<String, dynamic> responseBody = response.responseData;

        for (var counter in responseBody['data']) {
          CountingCard countingCard = CountingCard(
            model: TaskCounterModel(
              taskNumber: counter['sum'] < 10
                  ? '0${counter['sum']}'
                  : '${counter['sum']}',
              taskName: counter['_id'],
            ),
          );
          taskCounterList.add(countingCard);
          update();
        }
      } else {
        _errorMessage = response.errorMessage;
      }
    } catch (e) {
      _errorMessage = e.toString();
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

  Future<void> _deleteTask(String id) async {
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      mySnackBar('Task Deleted');
      getNewTasks();
      getTaskCounter();
    } catch (e) {
      mySnackBar(e.toString());
    }
  }

  Future<void> _onEditConfirm(String id) async {
    try {
      await NetworkCaller.getRequest(
        url: NetworkUrls.updateTaskStatus(
          id: id,
          newStatus: listOfEditOption[_selectedIndex],
        ),
      );
      getNewTasks();
      getTaskCounter();
      _selectedIndex = 0;
      mySnackBar('Task Status Updated to $address');
      update();
    } catch (e) {
      mySnackBar('Something went wrong');
      _selectedIndex = 0;
      update();
    }
  }
}
