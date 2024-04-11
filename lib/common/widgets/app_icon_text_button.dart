import 'package:flutter/material.dart';

class AppIconTextButton extends StatelessWidget {
  const AppIconTextButton(
      {super.key, required this.text, required this.icon, this.onPressed});
  final String text;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          elevation: 3),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 30, color: Colors.blue[800]),
          ),
        ],
      ),
    );
  }
}
