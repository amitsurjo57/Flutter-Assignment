import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/ui/controllers/progress_task_controller.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Common%20Widget/no_task_message.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    _getProgressTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: ProgressTaskController(),
          builder: (progressTaskController) {
            return RefreshIndicator(
              onRefresh: _getProgressTasks,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              child: Visibility(
                visible: !progressTaskController.inProgress,
                replacement: const CenterProgressIndicator(),
                child: Visibility(
                  visible: progressTaskController.taskList.isNotEmpty,
                  replacement: NoTaskMessage(refresh: _getProgressTasks),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: progressTaskController.taskList.length,
                    itemBuilder: (context, index) =>
                        progressTaskController.taskList[index],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _getProgressTasks() async {
    bool isSuccess = await _progressTaskController.getProgressTasks();

    if(!isSuccess){
      mySnackBar(_progressTaskController.errorMessage!);
    }
  }
}
