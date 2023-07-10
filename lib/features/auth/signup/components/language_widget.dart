// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/localization/localization_bloc.dart';
import 'package:bloc_cart_app/blocs/localization/localization_event.dart';
import 'package:flutter/material.dart';

import 'package:bloc_cart_app/commons/models/language_model.dart';
import 'package:bloc_cart_app/localizations/localization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageWidget extends StatefulWidget {
  final double height;
  final ValueSetter<String> onChange;
  final LocalizationController localizationController;
  const LanguageWidget({
    Key? key,
    required this.height,
    required this.onChange,
    required this.localizationController,
  }) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      alignment: Alignment.center,
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<LocalizationBloc>().add(LocalizationSetLanguageEvent(
                  languageCode: languages[index].code));
                 widget.onChange(languages[index].code);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                languages[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.localizationController.currentLanguage ==
                          languages[index].code
                      ? Colors.blue.shade800
                      : Colors.black54,
                  fontSize: widget.localizationController.currentLanguage ==
                          languages[index].code
                      ? 18
                      : 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
