import 'package:flutter/material.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Starting%20App/checking_account_sign_button.dart';
import 'package:greeting_app/widgets/Starting%20App/starting_action_button.dart';
import 'package:greeting_app/widgets/Starting%20App/user_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(),
                const SizedBox(height: 40),
                buildUserTextField(_emailController, 'email'),
                const SizedBox(height: 20),
                buildUserTextField(_passController, 'password'),
                const SizedBox(height: 20),
                button(),
                const SizedBox(height: 80),
                forgetPass(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UserTextField buildUserTextField(
      TextEditingController controller, String hintText) {
    return UserTextField(
      controller: controller,
      hintText: hintText,
    );
  }

  StartingActionButton button() {
    return const StartingActionButton(
      child: Icon(
        Icons.arrow_forward_ios,
        size: 32,
        color: Colors.white,
      ),
    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        CheckingAccountSignButton(
          askAccount: 'Don\'t have account? ',
          askSingUpIn: 'Sign up',
          tapOnAskSignUpIn: () {},
        ),
      ],
    );
  }
}
