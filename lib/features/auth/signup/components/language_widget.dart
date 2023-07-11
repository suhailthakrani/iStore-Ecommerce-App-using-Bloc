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
              child: Column(
                children: [
                  EasyLocalization.of(context)?.currentLocale?.languageCode ==
                          languages[index].code
                      ? Container(
                          height: 38,
                          margin: const EdgeInsets.only(right: 12),
                          alignment: Alignment.center,
                          width: languages[index].name.length * 12,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            languages[index].name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : Padding(
                        padding: const EdgeInsets.only(right: 12, top: 10),
                        child: Text(
                            languages[index].name,
                          
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                      ),
                ],
              ));
        },
      ),
    );
  }
}
