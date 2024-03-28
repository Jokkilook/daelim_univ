import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false});
  final String labelText;
  final TextEditingController controller;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: obscureText,
      controller: controller,
      style: const TextStyle(fontSize: 30),
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
