import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class StartingActionButton extends StatelessWidget {
  final Widget child;
  const StartingActionButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
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
