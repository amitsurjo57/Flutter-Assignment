import 'package:flutter/material.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
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
          Column(
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
              button(),
            ],
          )
        ],
      ),
    );
  }

  MyButton button() {
    return MyButton(
      onPressed: () {
        // TODO: Implement Update profile
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
    );
  }

  UserTextField lastName() {
    return UserTextField(
      controller: _lastNameController,
      hintText: 'Last Name',
    );
  }

  UserTextField firstName() {
    return UserTextField(
      controller: _firstNameController,
      hintText: 'First Name',
    );
  }

  UserTextField email() {
    return UserTextField(
      controller: _emailController,
      hintText: 'Email',
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
}
