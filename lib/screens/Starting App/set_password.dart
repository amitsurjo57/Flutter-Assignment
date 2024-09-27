import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Starting%20App/join_with_us.dart';
import 'package:greeting_app/ui/navigate_to_signin_page.dart';
import 'package:greeting_app/widgets/Starting%20App/password_text_field.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Starting%20App/my_button.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool showPass = true;
  bool showConPass = true;

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        children: [
          buildHeader(),
          buildSubHeader(),
          const SizedBox(height: 12),
          buildPasswordTextField(),
          const SizedBox(height: 12),
          buildConfirmPasswordTextField(),
          const SizedBox(height: 12),
          buildMyButton(),
          const SizedBox(height: 50),
          NavigateToSignInPage.navigateToSignInPage(context),
        ],
      ),
    );
  }

  MyButton buildMyButton() {
    return MyButton(
      child: const Text(
        'Confirm',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JoinWithUs(),
          ),
        );
      },
    );
  }

  PasswordTextField buildConfirmPasswordTextField() {
    return PasswordTextField(
      textEditingController: _confirmPassController,
      hintText: 'Confirm Password',
    );
  }

  PasswordTextField buildPasswordTextField() {
    return PasswordTextField(
      textEditingController: _passController,
      hintText: 'Password',
    );
  }

  Text buildHeader() {
    return const Text(
      'Set Password',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildSubHeader() {
    return const Text(
      'Minimum length password 8 character with Letter and number combination',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
