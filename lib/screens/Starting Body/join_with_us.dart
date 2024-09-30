import 'package:flutter/material.dart';
import 'package:greeting_app/ui/navigate_to_signin_page.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool showPass = true;

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
      body: BackgroundWidget(
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
    );
  }

  MyButton buildMyButton() {
    return MyButton(
      onPressed: () {
        // TODO: Implement Register button
      },
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
    );
  }

  UserTextField buildLastNameTextField() {
    return UserTextField(
      controller: _lastNameController,
      hintText: 'Last Name',
    );
  }

  UserTextField buildFirstNameTextField() {
    return UserTextField(
      controller: _firstNameController,
      hintText: 'First Name',
    );
  }

  UserTextField buildEmailTextField() {
    return UserTextField(
      controller: _emailController,
      hintText: 'Email',
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
}
