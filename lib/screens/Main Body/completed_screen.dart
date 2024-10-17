import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Common%20Widget/no_task_message.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskWidget> taskList = [];
  bool _inProgress = false;
  int _selectedIndex = 1;
  String address = 'Completed';

  List<String> listOfEditOption = [
    'New',
    'Completed',
    'Canceled',
    'Progress',
  ];

  @override
  void initState() {
    _getCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getCompletedTasks,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Visibility(
          visible: !_inProgress,
          replacement: const CenterProgressIndicator(),
          child: Visibility(
            visible: taskList.isNotEmpty,
            replacement: NoTaskMessage(refresh: _getCompletedTasks),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: taskList.length,
              itemBuilder: (context, index) => taskList[index],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTasks() async {
    try {
      _inProgress = true;
      taskList.clear();
      setState(() {});
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: NetworkUrls.tasksList(taskStatus: 'Completed'),
      );

      if (response.isSuccess) {
        _inProgress = false;
        setState(() {});
        Map<String, dynamic> newTaskResponse = response.responseData;

        for (var task in newTaskResponse['data']) {
          setState(() {
            TaskWidget newTask = TaskWidget(
              taskModel: TaskModel(
                title: task['title'] ?? '',
                subTitle: task['description'] ?? '',
                date: task['createdDate'] ?? '',
                status: task['status'] ?? '',
                statusColor: Colors.green,
                onEdit: () => _onTapEdit(task['_id'] ?? ''),
                onDelete: () => _deleteTask(task['_id'] ?? ''),
              ),
            );
            taskList.add(newTask);
          });
        }
      } else {
        _snackBar(response.errorMessage);
      }
    } catch (e) {
      _snackBar(e.toString());
    }
  }

  void _onTapEdit(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Edit Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: listOfEditOption.map((e) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      _selectedIndex = listOfEditOption
                          .indexWhere((element) => element == e);
                      address = e;
                    });
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
                onPressed: _onPopEditOptionScreen,
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => _onTapEditOkayOption(id, setState),
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onPopEditOptionScreen() {
    Navigator.pop(context);
  }

  Future<void> _onTapEditOkayOption(String id, StateSetter setState) async {
    try {
      await NetworkCaller.getRequest(
        url: NetworkUrls.updateTaskStatus(id, listOfEditOption[_selectedIndex]),
      );
      _getCompletedTasks();
      _onPopEditOptionScreen();
      _snackBar('Task Status Updated to $address');
      setState(() {});
    } catch (e) {
      _snackBar('Something went wrong');
    }
  }

  Future<void> _deleteTask(String id) async {
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      _getCompletedTasks();
      _snackBar('Task Deleted');
      setState(() {});
    } catch (e) {
      _snackBar('Something went wrong');
    }
  }

  void _snackBar(String msg) {
    mySnackBar(context, msg);
  }
}
