// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Widget prefix;
  
  Function(String value) onChanged;
  CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.prefix,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      prefix: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          
        ),
        child: prefix,
      ),
      padding: const EdgeInsets.all(12),
      placeholder: hint,
      style: TextStyle(color: Colors.white),
      onChanged: onChanged,
      controller: controller,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
