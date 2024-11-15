import 'package:get/get.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';

class CreateNewTaskController extends GetxController {

  bool _inProgress = false;
  bool _isSuccess = false;
  String _errorMessage = ' ';
  bool _shouldRefreshPreviousPage = false;

  bool get inProgress => _inProgress;

  bool get isSuccess => _isSuccess;

  bool get shouldRefreshPreviousPage => _shouldRefreshPreviousPage;

  String get errorMessage => _errorMessage;

  Future<bool> onAddNewTask({String? title, String? description}) async {
    _inProgress = true;
    _shouldRefreshPreviousPage = true;
    update();
    final Map<String, dynamic> taskBody = {
      "title": title ?? ' ',
      "description": description ?? ' ',
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: NetworkUrls.createTask,
      body: taskBody,
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    return _isSuccess;
  }
}
