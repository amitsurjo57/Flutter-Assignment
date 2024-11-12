import 'package:get/get.dart';
import 'package:greeting_app/data/models/login_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/ui/controllers/auth_controllers.dart';

class LogInController extends GetxController {
  String? _errorMessage;
  bool isSuccess = false;
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> logIn({required String email, required String password}) async {
    _inProgress = true;
    update();
    Map<String, dynamic> userLogInfo = {
      "email": email,
      "password": password,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: NetworkUrls.logIn,
      body: userLogInfo,
    );

    if (response.isSuccess) {
      isSuccess = true;
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthControllers.saveAccessToken(loginModel.token!);
      await AuthControllers.saveUserData(loginModel.data!);
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
