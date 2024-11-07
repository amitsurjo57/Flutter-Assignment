import 'package:flutter/material.dart';
import 'package:greeting_app/data/controllers/auth_controllers.dart';
import 'package:greeting_app/data/models/login_model.dart';
import 'package:greeting_app/data/models/network_response.dart';
import 'package:greeting_app/data/services/network_caller.dart';
import 'package:greeting_app/data/utils/network_urls.dart';
import 'package:greeting_app/screens/Main%20Body/home_screen.dart';
import 'package:greeting_app/screens/Starting%20Body/enter_email.dart';
import 'package:greeting_app/widgets/Common%20Widget/snack_bar.dart';
import 'package:greeting_app/widgets/Common%20Widget/center_progress_indicator.dart';
import 'package:greeting_app/widgets/Starting%20App/password_text_field.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Starting%20App/checking_account_sign_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/user_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _inProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _globalKey,
        child: BackgroundWidget(
          children: [
            buildHeader(),
            const SizedBox(height: 40),
            emailTextField(),
            const SizedBox(height: 20),
            passwordTextField(),
            const SizedBox(height: 20),
            button(),
            const SizedBox(height: 80),
            forgetPass(),
          ],
        ),
      ),
    );
  }

  PasswordTextField passwordTextField() {
    return PasswordTextField(
      textEditingController: _passController,
      hintText: 'Password',
    );
  }

  UserTextField emailTextField() {
    return UserTextField(
      controller: _emailController,
      hintText: 'Email',
      validateMSG: 'Enter your email',
    );
  }

  Widget button() {
    return Visibility(
      visible: !_inProgress,
      replacement: const CenterProgressIndicator(),
      child: MyButton(
        onPressed: onLonIn,
      ),
    );
  }

  void onLonIn() {
    if (_globalKey.currentState!.validate()) {
      logIn();
    }
  }

  Future<void> logIn() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> userLogInfo = {
      "email": _emailController.text.trim(),
      "password": _passController.text,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: NetworkUrls.logIn,
      body: userLogInfo,
    );
    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthControllers.saveAccessToken(loginModel.token!);
      await AuthControllers.saveUserData(loginModel.data!);
      navigateFunc();
      snackBar('Successfully Log In');
    } else {
      snackBar('No User Found');
    }
  }

  void navigateFunc() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (_) => false,
    );
  }

  void snackBar(String msg) {
    mySnackBar(context, msg);
  }

  Text buildHeader() {
    return const Text(
      'Get Started With',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget forgetPass() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // TODO: Forgot Password
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          CheckingAccountSignButton(
            askAccount: 'Don\'t have account? ',
            askSingUpIn: 'Sign up',
            tapOnAskSignUpIn: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EnterEmail(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
