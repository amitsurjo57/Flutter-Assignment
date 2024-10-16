import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/screens/Main%20Body/create_new_task_screen.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Common%20Widget/no_task_message.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Main%20App/counting_card.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskWidget> taskList = [];
  bool _inProgress = false;
  int _selectedIndex = 0;

  List<String> listOfEditOption = [
    'New',
    'Completed',
    'Canceled',
    'Progress',
  ];

  @override
  void initState() {
    _getNewTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: RefreshIndicator(
        onRefresh: _getNewTasks,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Visibility(
          visible: !_inProgress,
          replacement: const CenterProgressIndicator(),
          child: Column(
            children: [
              countingHeader(),
              Visibility(
                visible: taskList.isNotEmpty,
                replacement: Expanded(
                  child: NoTaskMessage(refresh: _getNewTasks),
                ),
                child: mainTasks(context),
              ),
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

  FloatingActionButton floatingActionButton() {
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
                onEdit: () => _onTapEdit(task['_id']),
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
    try {
      await NetworkCaller.getRequest(url: NetworkUrls.deleteTasks(id: id));
      _getNewTasks();
      _snackBar('Task Deleted');
      setState(() {});
    } catch (e) {
      _snackBar('Something went wrong');
    }
  }

  void _onTapEdit(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: listOfEditOption.map((e) {
              int index =
                  listOfEditOption.indexWhere((element) => element == e);
              return ListTile(
                onTap: () => setState(() => _selectedIndex = index),
                selected: _selectedIndex == index,
                selectedColor: Colors.green,
                selectedTileColor: Colors.green[100],
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
              onPressed: () async {
                try {
                  await NetworkCaller.getRequest(
                    url: NetworkUrls.updateTaskStatus(
                        id, listOfEditOption[_selectedIndex]),
                  );
                  _getNewTasks();
                  _snackBar('Task Status Updated');
                  setState(() {});
                } catch (e) {
                  _snackBar('Something went wrong');
                }
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
