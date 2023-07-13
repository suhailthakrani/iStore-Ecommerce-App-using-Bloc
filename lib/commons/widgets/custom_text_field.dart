// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Widget prefix;
  bool obsecure;
  Function(String value) onChanged;
  
  Widget suffix;
  
 
  CustomTextField({
    Key? key,
    this.obsecure = false,
    this.suffix = const SizedBox(),
    required this.hint,
    required this.controller,
    required this.prefix,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      obscureText: obsecure,
      prefix: Container(
        padding: const EdgeInsets.all(10.0),
        decoration:  BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          
        ),
        child: prefix,
      ),
      suffix: suffix,
      padding: const EdgeInsets.all(12),
      placeholder: hint.tr(),
      placeholderStyle: const TextStyle(color: Colors.black54),
      style: const TextStyle(color: Colors.black54),
      
      onChanged: onChanged,
      controller: controller,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
