import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Sky { midnight, viridian, cerulean }

class TextP extends StatefulWidget {
  const TextP({super.key});

  @override
  State<TextP> createState() => _TextPState();
}

class _TextPState extends State<TextP> {
  Sky _selectedSegment = Sky.midnight;
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoPageScaffold(
        child: CupertinoPageScaffold(
          child:
              CupertinoButton(child: Text("Hellow World!", style: TextStyle(color: Colors.black),), onPressed: () {}),
        ),
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          middle: CupertinoSlidingSegmentedControl(
            children: {
              Sky.midnight: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  'Midnight',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Sky.viridian: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  'Viridian',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Sky.cerulean: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  'Cerulean',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            },
            groupValue: _selectedSegment,
            onValueChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedSegment = value;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
