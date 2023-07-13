import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedCategories = [];

  final List<String> categories = [
    "Air Pods",
    "Apple Watch",
    "iPhone",
    "AirTag & Accessories",
    "Keyboards",
    "Power & Cables",
    "Cases & Protection",
    "Mice & Trackpads",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, selectedCategories);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          'Filter Page',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(children: [],)
    );
  }
}

//  onChanged: (value) {
//               setState(() {
//                 if (value!) {
//                   selectedCategories.add(category);
//                 } else {
//                   selectedCategories.remove(category);
//                 }
//               });
//             },
