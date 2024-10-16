import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
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

  @override
  void initState() {
    _getCompletedTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getCompletedTask,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Visibility(
          visible: !_inProgress,
          replacement: const CenterProgressIndicator(),
          child: Expanded(
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

  Future<void> _getCompletedTask() async {
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
                title: task['title'],
                subTitle: task['description'],
                date: task['createdDate'],
                status: task['status'],
                statusColor: Colors.blue,
                onEdit: () => _onTapEdit(context),
                onDelete: () => _deleteTask(task['_id']),
              ),
            );
            taskList.add(newTask);
          });
        }
      } else {
        // _snackBar(response.errorMessage);
      }
    } catch (e) {
      // _snackBar(e.toString());
    }
  }

  void _onTapEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
              return ListTile(
                onTap: () {},
                title: Text(e),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTask(String id) async {
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      _getCompletedTask();
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
