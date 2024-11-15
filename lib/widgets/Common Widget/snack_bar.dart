import 'package:flutter/material.dart';
import 'package:get/get.dart';

void mySnackBar(String msg) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
