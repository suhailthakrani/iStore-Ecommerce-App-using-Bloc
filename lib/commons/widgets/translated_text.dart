// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TText extends StatelessWidget {
  final String text;
  final TextStyle style;
  List<String>? args;
  BuildContext? context;
  Map<String, String>? namedArgs;
  String? gender;
  TText(
    Key? key,
    this.text,
    this.style,
    this.args,
    this.context,
    this.namedArgs,
    this.gender,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    ).tr(
      args: args,
      context: context,
      namedArgs: namedArgs,
      gender: gender,
    );
  }
}
