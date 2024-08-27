import 'package:flutter/material.dart';
import '../const/appbar_title.dart';

PreferredSizeWidget buildAppBarForTabletDesktop({
  double? appBarFontSize,
  double? episodeFontSIze,
  double? aboutFontSIze,
  double horizontalGap = 16,
  FontWeight? appBarFontWeight,
  FontWeight? episodeFontWeight,
  FontWeight? aboutFontWeight,
}) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalGap),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appbarTitle(fontSize: appBarFontSize,fontWeight: appBarFontWeight),
          Row(
            children: [
              Text(
                "Episodes",
                style: TextStyle(fontSize: episodeFontSIze,fontWeight: episodeFontWeight),
              ),
              const SizedBox(width: 48),
              Text(
                "About",
                style: TextStyle(fontSize: aboutFontSIze,fontWeight: aboutFontWeight),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
