import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/screens/Main%20Body/create_new_task_screen.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Main%20App/counting_card.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';
import 'package:greeting_app/widgets/Starting%20App/center_progress_indicator.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskWidget> taskList = [];
  bool _inProgress = false;

  @override
  void initState() {
    _getNewTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(context),
      body: RefreshIndicator(
        onRefresh: _getNewTasks,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Visibility(
          visible: !_inProgress,
          replacement: const CenterProgressIndicator(),
          child: Column(
            children: [
              countingHeader(),
              mainTasks(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget countingHeader() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CountingCard(
              numberOfTask: 09,
              task: 'Canceled',
            ),
            CountingCard(
              numberOfTask: 09,
              task: 'Completed',
            ),
            CountingCard(
              numberOfTask: 09,
              task: 'Progress',
            ),
            CountingCard(
              numberOfTask: 09,
              task: 'New Task',
            ),
          ],
        ),
      ),
    );
  }

  Expanded mainTasks(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: taskList.length,
        itemBuilder: (context, index) => taskList[index],
      ),
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _onTapCreateTask(context);
      },
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: const Icon(Icons.add, size: 32),
    );
  }

  Future<void> _getNewTasks() async {
    try {
      _inProgress = true;
      taskList.clear();
      setState(() {});
      final NetworkResponse response = await NetworkCaller.getRequest(
        url: NetworkUrls.tasksList(taskStatus: 'New'),
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
        _snackBar(response.errorMessage);
      }
    } catch (e) {
      _snackBar(e.toString());
    }
  }

  Future<void> _deleteTask(String id) async {
    try{
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      _getNewTasks();
      _snackBar('Task Deleted');
      setState(() {});
    }catch(e){
      _snackBar('Something went wrong');
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
                onTap: () {
                  // TODO: On Tap in Task Status
                },
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
              onPressed: () {
                // TODO: On Edit Okay
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  void _onTapCreateTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewTaskScreen(),
      ),
    );
  }

  void _snackBar(String msg) {
    mySnackBar(context, msg);
  }
}
