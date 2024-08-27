import 'package:flutter/material.dart';

class MainContentButton extends StatelessWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final double? buttonFontSize;

  const MainContentButton({
    super.key,
    this.buttonHeight = 70,
    this.buttonWidth = 240,
    this.buttonFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
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
