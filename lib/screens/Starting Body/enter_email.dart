import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Starting%20Body/pin_verification.dart';
import 'package:greeting_app/ui/navigate_to_signin_page.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Common%20Widget/my_button.dart';
import 'package:greeting_app/widgets/Common%20Widget/user_text_field.dart';

class EnterEmail extends StatefulWidget {
  const EnterEmail({super.key});

  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
          buildUserTextField(),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PinVerification(),
          ),
        );
      },
    );
  }

  UserTextField buildUserTextField() {
    return UserTextField(
      controller: _emailController,
      hintText: 'Email',
    );
  }

  Text buildHeader() {
    return const Text(
      'Your Email Address',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildSubHeader() {
    return const Text(
      'A 6 digit verification pin will send to your email address',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
