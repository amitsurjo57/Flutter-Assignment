import 'package:get/get.dart';
import 'package:greeting_app/ui/controllers/log_in_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LogInController());
  }
}
