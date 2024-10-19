import 'package:flutter/material.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/screens/Starting%20Body/log_in_screen.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Common%20Widget/user_text_field.dart';
import 'package:greeting_app/widgets/Main%20App/tam_appbar.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Starting%20App/password_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _inProgressProfileGetDetails = false;
  bool _inProgressProfileUpdate = false;

  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _mobile = '';
  String _password = '';

  @override
  void initState() {
    _getProfileDetails();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TamAppbar(
        isProfileScreenOpen: true,
      ),
      body: BackgroundWidget(
        children: [
          Visibility(
            visible: !_inProgressProfileGetDetails,
            replacement: const CenterProgressIndicator(),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heading(),
                  const SizedBox(height: 16),
                  photo(),
                  const SizedBox(height: 16),
                  email(),
                  const SizedBox(height: 16),
                  firstName(),
                  const SizedBox(height: 16),
                  lastName(),
                  const SizedBox(height: 16),
                  mobile(),
                  const SizedBox(height: 16),
                  password(),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_inProgressProfileUpdate,
                    replacement: const CenterProgressIndicator(),
                    child: button(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getProfileDetails() async {
    try {
      _inProgressProfileGetDetails = true;
      setState(() {});
      NetworkResponse response = await NetworkCaller.getRequest(
        url: NetworkUrls.profileDetails,
      );

      if (response.isSuccess) {
        _inProgressProfileGetDetails = false;
        setState(() {});
        Map<String, dynamic> mainBody = response.responseData;
        List<dynamic> mainData = mainBody['data'];
        _emailController.text = mainData.first['email'] ?? '';
        _firstNameController.text = mainData.first['firstName'] ?? '';
        _lastNameController.text = mainData.first['lastName'] ?? '';
        _mobileController.text = mainData.first['mobile'] ?? '';
        _passwordController.text = mainData.first['password'] ?? '';

        _email = mainData.first['email'] ?? '';
        _firstName = mainData.first['firstName'] ?? '';
        _lastName = mainData.first['lastName'] ?? '';
        _mobile = mainData.first['mobile'] ?? '';
        _password = mainData.first['password'] ?? '';
      } else {
        debugPrint(response.errorMessage);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _profileUpdate() async {
    try {
      _inProgressProfileUpdate = true;
      setState(() {});
      Map<String, dynamic> profileBody = {
        "email": _emailController.text.trim(),
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "mobile": _mobileController.text.trim(),
        "password": _passwordController.text,
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        url: NetworkUrls.profileUpdate,
        body: profileBody,
      );

      _inProgressProfileUpdate = false;
      setState(() {});

      if (response.isSuccess) {
        _snackBar('Profile Updated Successfully. Log In again.');
        _navigateToLogInScreen();
      } else {
        _inProgressProfileUpdate = false;
        setState(() {});
        _snackBar('Something went wrong');
      }
    } catch (e) {
      _snackBar('Something went wrong');
    }
  }

  void _snackBar(String msg) {
    mySnackBar(context, msg);
  }

  MyButton button() {
    return MyButton(
      onPressed: () {
        if (_globalKey.currentState!.validate()) {
          if (_emailController.text == _email &&
              _firstNameController.text == _firstName &&
              _lastNameController.text == _lastName &&
              _mobileController.text == _mobile &&
              _passwordController.text == _password) {
            Navigator.pop(context);
          } else {
            _profileUpdate();
          }
        }
      },
    );
  }

  PasswordTextField password() {
    return PasswordTextField(
      textEditingController: _passwordController,
      hintText: 'Password',
    );
  }

  UserTextField mobile() {
    return UserTextField(
      controller: _mobileController,
      hintText: 'Mobile',
      textInputType: TextInputType.phone,
      validateMSG: 'Enter your phone',
    );
  }

  UserTextField lastName() {
    return UserTextField(
      controller: _lastNameController,
      hintText: 'Last Name',
      validateMSG: 'Enter last name',
    );
  }

  UserTextField firstName() {
    return UserTextField(
      controller: _firstNameController,
      hintText: 'First Name',
      validateMSG: 'Enter first name',
    );
  }

  UserTextField email() {
    return UserTextField(
      controller: _emailController,
      hintText: 'Email',
      validateMSG: 'Enter your email',
    );
  }

  Container photo() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: const Text(
              "Photos",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Text heading() {
    return const Text(
      "Update Profile",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
      ),
    );
  }

  Future<void> _navigateToLogInScreen() async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
      (_) => false,
    );
  }
}
