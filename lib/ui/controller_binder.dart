import 'package:get/get.dart';
import 'package:greeting_app/ui/controllers/canceled_task_controller.dart';
import 'package:greeting_app/ui/controllers/completed_task_controller.dart';
import 'package:greeting_app/ui/controllers/log_in_controller.dart';
import 'package:greeting_app/ui/controllers/new_task_controller.dart';
import 'package:greeting_app/ui/controllers/progress_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LogInController());
    Get.put(NewTaskController());
    Get.put(CompletedTaskController());
    Get.put(CanceledTaskController());
    Get.put(ProgressTaskController());
  }
}
