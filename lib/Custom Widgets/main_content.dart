import 'package:flutter/material.dart';
import 'package:ostad_flutter_assignment/const/main_content_const.dart';

class MainContent extends StatelessWidget {
  final TextStyle? mainTitleTextStyle;
  final TextStyle? subTitleTextStyle;
  final TextAlign? mainTextAlign;
  final TextAlign? subTextAlign;
  final CrossAxisAlignment crossAxisAlignment;

  const MainContent({
    super.key,
    this.mainTitleTextStyle,
    this.subTitleTextStyle,
    this.mainTextAlign,
    this.subTextAlign,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(mainTitle,style: mainTitleTextStyle,textAlign: mainTextAlign),
        const SizedBox(height: 12),
        Text(subTitle,style: subTitleTextStyle,textAlign: subTextAlign),
      ],
    );
  }
}
