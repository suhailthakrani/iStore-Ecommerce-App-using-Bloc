
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:bloc_cart_app/commons/models/language_model.dart';


class LanguageWidget extends StatefulWidget {
  final double height;
  // final ValueSetter<String> onChange;

  const LanguageWidget({
    Key? key,
    required this.height,
    // required this.onChange,
  }) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
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
            onTap: () async {
              final selectedLocale = Locale(languages[index].code);
              final isLocaleSupported = EasyLocalization.of(context)
                      ?.supportedLocales
                      .contains(selectedLocale) ??
                  false;
              if (isLocaleSupported) {
                await EasyLocalization.of(context)?.setLocale(selectedLocale);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                languages[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: EasyLocalization.of(context)?.currentLocale?.languageCode
                      == languages[index].code
                          ? Colors.blue.shade800
                          : Colors.black54,
                  fontSize:
                      EasyLocalization.of(context)?.currentLocale?.languageCode == languages[index].code
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
