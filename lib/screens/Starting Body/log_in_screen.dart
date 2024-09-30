import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Main%20Body/home_screen.dart';
import 'package:greeting_app/screens/Starting%20Body/enter_email.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
      body: BackgroundWidget(
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
    );
  }

  MyButton button() {
    return MyButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (_) => false,
        );
      },
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
