import 'package:flutter/material.dart';
import 'package:ostad_flutter_assignment/Custom%20Widgets/appbar_tablet_desktop.dart';

import '../Custom Widgets/main_content.dart';
import '../const/main_content_button.dart';

class TabletHomeLayout extends StatelessWidget {
  const TabletHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTabletAppbar(),
      body: buildTabletBody(),
    );
  }

  Widget buildTabletBody() {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MainContent(
            mainTitleTextStyle: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
            ),
            mainTextAlign: TextAlign.center,
            subTitleTextStyle: TextStyle(
              fontSize: 28,
            ),
            subTextAlign: TextAlign.center,
          ),
          SizedBox(height: 80),
          MainContentButton(
            buttonWidth: 350,
            buttonHeight: 100,
            buttonFontSize: 32,
          ),
        ],
      ),
    );
  }

  PreferredSize buildTabletAppbar() {
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
            ),
          ],
        ),
      ),
    );
  }
}
