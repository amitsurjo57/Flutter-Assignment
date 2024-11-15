import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/ui/controllers/completed_task_controller.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Common%20Widget/no_task_message.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    _getCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: CompletedTaskController(),
        builder: (completedTaskController) {
          return RefreshIndicator(
            onRefresh: _getCompletedTasks,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: Visibility(
              visible: !completedTaskController.inProgress,
              replacement: const CenterProgressIndicator(),
              child: Visibility(
                visible: completedTaskController.taskList.isNotEmpty,
                replacement: NoTaskMessage(refresh: _getCompletedTasks),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: completedTaskController.taskList.length,
                  itemBuilder: (context, index) =>
                  completedTaskController.taskList[index],
                ),
              ),
            )
          );
        }
      ),
    );
  }

  Future<void> _getCompletedTasks() async {
    try {
     bool isSuccess = await _completedTaskController.getCompletedTasks();

     if(!isSuccess){
       mySnackBar(_completedTaskController.errorMessage!);
     }
    } catch (e) {
      mySnackBar(e.toString());
    }
  }
}
