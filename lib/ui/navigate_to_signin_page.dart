import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Starting%20App/log_in_screen.dart';
import 'package:greeting_app/widgets/Starting%20App/checking_account_sign_button.dart';

class NavigateToSignInPage {
  static Center navigateToSignInPage(BuildContext context) {
    return Center(
      child: CheckingAccountSignButton(
        askAccount: 'Have account? ',
        askSingUpIn: 'Sign In',
        tapOnAskSignUpIn: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LogInScreen(),
            ),
            (_) => false,
          );
        },
      ),
    );
  }
}
