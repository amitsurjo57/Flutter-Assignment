import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greeting_app/screens/Main%20Body/home_screen.dart';
import 'package:greeting_app/screens/Starting%20Body/log_in_screen.dart';
import 'package:greeting_app/screens/Starting%20Body/splash_screen.dart';
import 'package:greeting_app/ui/controller_binder.dart';
import 'package:greeting_app/utils/common_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey dialogKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: CommonColor.commonColor,
        ),
      ),
      initialBinding: ControllerBinder(),
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name : (context) => const SplashScreen(),
        LogInScreen.name : (context) => const LogInScreen(),
        HomeScreen.name : (context) => const HomeScreen(),
      },
    );
  }
}
