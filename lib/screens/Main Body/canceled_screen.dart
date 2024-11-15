import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/ui/controllers/canceled_task_controller.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Common%20Widget/no_task_message.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  final CanceledTaskController _canceledTaskController =
      Get.find<CanceledTaskController>();

  @override
  void initState() {
    _getCanceledTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: CanceledTaskController(),
        builder: (canceledTaskController) {
          return RefreshIndicator(
            onRefresh: _getCanceledTasks,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: Visibility(
              visible: !canceledTaskController.inProgress,
              replacement: const CenterProgressIndicator(),
              child: Visibility(
                visible: canceledTaskController.taskList.isNotEmpty,
                replacement: NoTaskMessage(refresh: _getCanceledTasks),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemCount: canceledTaskController.taskList.length,
                  itemBuilder: (context, index) => canceledTaskController.taskList[index],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> _getCanceledTasks() async {
    bool isSuccess = await _canceledTaskController.getCanceledTasks();

    if(!isSuccess){
      mySnackBar(_canceledTaskController.errorMessage!);
    }
  }
}
