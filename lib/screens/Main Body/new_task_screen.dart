import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/Model/Main%20App/task_counter_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/screens/Main%20Body/create_new_task_screen.dart';
import 'package:greeting_app/ui/controllers/new_task_controller.dart';
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
  List<CountingCard> taskCounterList = [];
  String address = 'New';

  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  List<String> listOfEditOption = [
    'New',
    'Completed',
    'Canceled',
    'Progress',
  ];

  @override
  void initState() {
    _rebuild();
    super.initState();
  }

  Future<void> _rebuild() async {
    await _getTaskCounter();
    await _getNewTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      body: RefreshIndicator(
        onRefresh: _rebuild,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: GetBuilder(
            init: NewTaskController(),
            builder: (context) {
              return Visibility(
                visible: !context.inProgress,
                replacement: const CenterProgressIndicator(),
                child: Column(
                  children: [
                    countingHeader(),
                    GetBuilder(
                        init: NewTaskController(),
                        builder: (context) {
                          return Visibility(
                            visible: context.taskList.isNotEmpty,
                            replacement: Expanded(
                              child: NoTaskMessage(refresh: _rebuild),
                            ),
                            child: mainTasks(),
                          );
                        }),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget countingHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemCount: taskCounterList.length,
          itemBuilder: (context, index) => taskCounterList[index],
        ),
      ),
    );
  }

  Expanded mainTasks() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: _newTaskController.taskList.length,
        itemBuilder: (context, index) => _newTaskController.taskList[index],
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: _onTapCreateTask,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: const Icon(Icons.add, size: 32),
    );
  }

  Future<void> _getNewTasks() async {
    try {
      bool isSuccess = await _newTaskController.getNewTasks();

      if (!isSuccess) {
        _snackBar(_newTaskController.errorMessage!);
      }
    } catch (e) {
      _snackBar(e.toString());
    }
  }

  Future<void> _getTaskCounter() async {
    try {
      NetworkResponse response =
          await NetworkCaller.getRequest(url: NetworkUrls.taskCounter);
      if (response.isSuccess) {
        taskCounterList.clear();
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
        }
      } else {
        _snackBar(response.errorMessage);
      }
    } catch (e) {
      _snackBar('Something went wrong');
    }
  }

  Future<void> _onTapCreateTask() async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewTaskScreen(),
      ),
    );
    if (result!) {
      _rebuild();
    }
  }

  void _snackBar(String msg) {
    mySnackBar(context, msg);
  }

  void _onPopEditOptionScreen() {
    Navigator.pop(context);
  }
}
