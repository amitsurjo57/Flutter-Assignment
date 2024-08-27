import 'package:flutter/material.dart';
import 'package:ostad_flutter_assignment/Custom%20Widgets/main_content.dart';
import 'package:ostad_flutter_assignment/const/appbar_title.dart';
import 'package:ostad_flutter_assignment/const/main_content_button.dart';

class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      body: buildMobileBody(),
    );
  }

  Widget buildMobileBody() {
    return const Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
        horizontal: 32,
      ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MainContent(
              mainTitleTextStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              mainTextAlign: TextAlign.center,
              subTitleTextStyle: TextStyle(
                fontSize: 14,
              ),
              subTextAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
            MainContentButton(),
            SizedBox(height: 160),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            appbarTitle(fontSize: 16,fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          buildHeaderDrawer(),
          buildContentDrawer(),
        ],
      ),
    );
  }

  Padding buildContentDrawer() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.present_to_all,
                    size: 28,
                  ),
                  SizedBox(height: 24),
                  Icon(
                    Icons.message,
                    size: 28,
                  ),
                ],
              ),
              SizedBox(width: 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Episodes",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "About",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(width: 32),
            ],
          ),
        ],
      ),
    );
  }

  Container buildHeaderDrawer() {
    return Container(
      height: 240,
      width: double.infinity,
      color: Colors.greenAccent,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SKILL UP NOW",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "TAP HERE",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
