import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class MySnackBar {
  static mySnackBar(
    BuildContext context, {
    required String message,
        required IconData icon,
  }) {
    Flushbar(
      message: message,
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      icon: Icon(icon,size:24, color: Colors.white),
      shouldIconPulse: false,
      backgroundColor: Colors.grey.shade800,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(24),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    ).show(context);
  }
}
