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
      fontWeight: FontWeight.w500,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          askAccount,
          style: textStyle,
        ),
        GestureDetector(
          onTap: tapOnAskSignUpIn,
          child: Text(
            askSingUpIn,
            style: textStyle.copyWith(
              color: CommonColor.commonColor,
            ),
          ),
        ),
      ],
    );
  }
}
