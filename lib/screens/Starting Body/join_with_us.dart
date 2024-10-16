import 'package:flutter/material.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/ui/navigate_to_signin_page.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Starting%20App/password_text_field.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/user_text_field.dart';

class JoinWithUs extends StatefulWidget {
  const JoinWithUs({super.key});

  @override
  State<JoinWithUs> createState() => _JoinWithUsState();
}

class _JoinWithUsState extends State<JoinWithUs> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPass = true;

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _globalKey,
        child: BackgroundWidget(
          children: [
            buildHeader(),
            const SizedBox(height: 12),
            buildEmailTextField(),
            const SizedBox(height: 12),
            buildFirstNameTextField(),
            const SizedBox(height: 12),
            buildLastNameTextField(),
            const SizedBox(height: 12),
            buildMobileField(),
            const SizedBox(height: 12),
            buildPasswordField(),
            const SizedBox(height: 12),
            buildMyButton(),
            const SizedBox(height: 50),
            NavigateToSignInPage.navigateToSignInPage(context),
          ],
        ),
      ),
    );
  }

  PasswordTextField buildPasswordField() {
    return PasswordTextField(
      textEditingController: _passwordController,
      hintText: 'Password',
    );
  }

  UserTextField buildMobileField() {
    return UserTextField(
      controller: _mobileController,
      hintText: 'Mobile',
      textInputType: TextInputType.phone,
      validateMSG: 'Enter your phone number',
    );
  }

  UserTextField buildLastNameTextField() {
    return UserTextField(
      controller: _lastNameController,
      hintText: 'Last Name',
      validateMSG: 'Enter last name',
    );
  }

  UserTextField buildFirstNameTextField() {
    return UserTextField(
      controller: _firstNameController,
      hintText: 'First Name',
      validateMSG: 'Enter first name',
    );
  }

  UserTextField buildEmailTextField() {
    return UserTextField(
      controller: _emailController,
      hintText: 'Email',
      validateMSG: 'Enter your email',
    );
  }

  Text buildHeader() {
    return const Text(
      'Join With Us',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildMyButton() {
    return Visibility(
      visible: !_inProgress,
      replacement: const CenterProgressIndicator(),
      child: MyButton(
        onPressed: onSignUp,
      ),
    );
  }

  void onSignUp() {
    if (_globalKey.currentState!.validate()) {
      signUP();
    }
  }

  Future<void> signUP() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> userRegInfo = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: NetworkUrls.registration,
      body: userRegInfo,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      clearField();
      snackBar('New User created');
    } else {
      snackBar(response.errorMessage);
    }
  }

  void snackBar(String msg) {
    mySnackBar(context, msg);
  }

  void clearField() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
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
}
