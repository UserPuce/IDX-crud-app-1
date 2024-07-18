import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? helper;
  final TextEditingController controller;
  const CustomInputText({
    super.key,
    required this.label,
    this.hintText,
    this.helper,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(label.length > 40 ? "${label.substring(0,40)}...": label),
          hintText: hintText,
          helper: helper != null
              ? Text(
                  helper!,
                  style: const TextStyle(fontSize: 11),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
