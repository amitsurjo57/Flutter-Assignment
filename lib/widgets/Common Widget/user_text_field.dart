import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class UserTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obSecureText;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final int maxLine;
  final int? maxLength;
  final String? validateMSG;

  const UserTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.textInputType,
    this.maxLength,
    this.maxLine = 1,
    this.obSecureText = false,
    this.validateMSG,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: CommonColor.commonColor,
      obscureText: obSecureText,
      keyboardType: textInputType,
      maxLines: maxLine,
      maxLength: maxLength,
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
      validator: (String? value){
        if(value?.isEmpty ?? true){
          return validateMSG;
        }
        return null;
      },
    );
  }
}
