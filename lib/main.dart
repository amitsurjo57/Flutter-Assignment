import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Starting%20Body/splash_screen.dart';
import 'package:greeting_app/utils/common_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CommonColor.commonColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
