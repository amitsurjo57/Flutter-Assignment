import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greeting_app/data/controllers/auth_controllers.dart';
import 'package:greeting_app/screens/Main%20Body/home_screen.dart';
import 'package:greeting_app/screens/Starting%20Body/log_in_screen.dart';
import 'package:greeting_app/widgets/Starting%20App/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async{
        await AuthControllers.getAccessToken();
        if (AuthControllers.isLoggedIn()) {
          await AuthControllers.getUserData();
          navigateToHomeScreen();
        }else{
          navigateToLogInScreen();
        }
      },
    );
  }

  void navigateToHomeScreen(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void navigateToLogInScreen(){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(children: [
        Center(
          child: SvgPicture.asset('assets/images/logo.svg'),
        ),
      ]),
    );
  }
}
