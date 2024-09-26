import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class MyButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  const MyButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 44,
      color: CommonColor.commonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
