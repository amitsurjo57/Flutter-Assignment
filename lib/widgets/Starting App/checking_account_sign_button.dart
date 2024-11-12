import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class CheckingAccountSignButton extends StatelessWidget {
  final String askAccount;
  final String askSingUpIn;
  final void Function() tapOnAskSignUpIn;

  const CheckingAccountSignButton({
    super.key,
    required this.askAccount,
    required this.askSingUpIn,
    required this.tapOnAskSignUpIn,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: askAccount,
            style: textStyle.copyWith(color: Colors.black),
          ),
          TextSpan(
            text: askSingUpIn,
            style: textStyle.copyWith(
              color: CommonColor.commonColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = tapOnAskSignUpIn,
          ),
        ],
      ),
    );
  }
}
