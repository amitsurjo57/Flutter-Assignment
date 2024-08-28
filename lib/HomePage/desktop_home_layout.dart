import 'package:flutter/material.dart';

import '../Custom Widgets/appbar_tablet_desktop.dart';
import '../Custom Widgets/main_content.dart';
import '../Custom Widgets/main_content_button.dart';

class DesktopHomeLayout extends StatelessWidget {
  const DesktopHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDesktopAppbar(),
      body:  buildDeskTopBody(),
    );
  }

  SizedBox buildDeskTopBody() {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 450,
              child: MainContent(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainTitleTextStyle: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
                mainTextAlign: TextAlign.start,
                subTitleTextStyle: TextStyle(
                  fontSize: 28,
                ),
                subTextAlign: TextAlign.start,
              ),
            ),
            MainContentButton(
              buttonWidth: 200,
              buttonHeight: 50,
              buttonFontSize: 20,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize buildDesktopAppbar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 120),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildAppBarForTabletDesktop(
              appBarFontSize: 24,
              aboutFontSIze: 24,
              episodeFontSIze: 24,
              appBarFontWeight: FontWeight.w600,
              episodeFontWeight: FontWeight.w600,
              aboutFontWeight: FontWeight.w600,
              horizontalGap: 50,
            ),
          ],
        ),
      ),
    );
  }
}
