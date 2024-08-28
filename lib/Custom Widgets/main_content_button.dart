import 'package:flutter/material.dart';
import 'package:ostad_flutter_assignment/const/color.dart';

class MainContentButton extends StatelessWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final double? buttonFontSize;

  const MainContentButton({
    super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.buttonFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: commonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "Join course",
            style: TextStyle(
              fontSize: buttonFontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
