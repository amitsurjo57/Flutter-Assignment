import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class UserTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureText;
  final TextInputType? textInputType;
  final Widget? suffixIcon;

  const UserTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.textInputType,
    this.obSecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: CommonColor.commonColor,
      obscureText: obSecureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
