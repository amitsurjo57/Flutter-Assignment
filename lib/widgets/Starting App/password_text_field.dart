import 'package:flutter/material.dart';
import 'package:greeting_app/utils/common_color.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const PasswordTextField(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool notShowPass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: CommonColor.commonColor,
      obscureText: notShowPass,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              notShowPass = !notShowPass;
            });
          },
          child: Icon(
            notShowPass ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Enter your password';
        }
        if (value!.length <= 6) {
          return 'Password should be at least 6 character';
        }
        return null;
      },
    );
  }
}
