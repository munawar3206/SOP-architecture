import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.text,
    required this.controller,
    required this.type,
    // this.inputFormatter,
  });

  final String text;
  final TextEditingController controller;
  final TextInputType type;
  // final inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // inputFormatters: inputFormatter,
      keyboardType: type,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter valid data";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }
}
