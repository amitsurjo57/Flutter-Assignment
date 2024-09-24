import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class UserTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const UserTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: CommonColor.commonColor,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
