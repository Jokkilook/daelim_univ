import 'package:flutter/material.dart';

//ignore: must_be_immutable
class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {super.key,
      this.formKey,
      required this.labelText,
      required this.controller,
      this.obscureText = false,
      this.validator});
  final GlobalKey<FormState>? formKey;
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
