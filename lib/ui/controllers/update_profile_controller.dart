import 'dart:convert';

import 'package:get/get.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/ui/controllers/auth_controllers.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;

  bool _isSuccess = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  bool get isSuccess => _isSuccess;

  String? get errorMessage => _errorMessage;

  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;

  Future<bool> profileUpdate({
    String? email,
    String? firstName,
    String? lastName,
    String? mobile,
    String? password,
  }) async {
    try {
      _inProgress = true;
      update();
      Map<String, dynamic> profileBody = {
        "email": email ?? ' ',
        "firstName": firstName ?? ' ',
        "lastName": lastName ?? ' ',
        "mobile": mobile ?? ' ',
        "password": password ?? ' ',
      };

      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        String convertedImage = base64Encode(imageBytes);
        profileBody["photo"] = convertedImage;
      }

      NetworkResponse response = await NetworkCaller.postRequest(
        url: NetworkUrls.profileUpdate,
        body: profileBody,
      );

      _inProgress = false;
      update();

      if (response.isSuccess) {
        await AuthControllers.clearUserData();
        _isSuccess = true;
      } else {
        _inProgress = false;
        update();
        _errorMessage = 'Something went wrong';
      }

      return _isSuccess;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
