import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

final Box contactsBox = Hive.box('contactsBox');

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style:  TextStyle(color: Colors.blueGrey.shade800, fontWeight: FontWeight.bold),
      ),
      backgroundColor:  Colors.grey[200], // Default color
    ),
  );
}


class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.blueGrey.shade800,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey.shade800, width: 2),
        ),
      ),
    );
  }
}
