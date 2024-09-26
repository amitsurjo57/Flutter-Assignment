import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Starting%20App/set_password.dart';
import 'package:greeting_app/utils/common_color.dart';
import 'package:greeting_app/ui/navigate_to_signin_page.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';
import 'package:greeting_app/widgets/Starting%20App/my_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        children: [
          buildHeader(),
          buildSubHeader(),
          const SizedBox(height: 12),
          buildPinField(),
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
            builder: (context) => const SetPassword(),
          ),
        );
      },
      child: const Text(
        'verify',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Text buildHeader() {
    return const Text(
      'Pin Verification',
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

  Widget buildPinField() {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      cursorColor: CommonColor.commonColor,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeColor: CommonColor.commonColor,
        selectedColor: CommonColor.commonColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
    );
  }
}
