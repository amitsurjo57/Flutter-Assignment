import 'package:flutter/material.dart';
import 'package:greeting_app/widgets/Starting%20App/user_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return UserTextField(
      controller: widget.textEditingController,
      hintText: widget.hintText,
      obSecureText: showPass,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            showPass = !showPass;
          });
        },
        child: showPass
            ? const Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
              )
            : const Icon(
                Icons.visibility_outlined,
                color: Colors.grey,
              ),
      ),
    );
  }
}
