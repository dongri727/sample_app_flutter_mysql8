import 'package:flutter/material.dart';

class Format extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const Format({
    required this.hintText,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.green),
        fillColor: Colors.lime,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.lime,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.lime,
            width: 1.0,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}