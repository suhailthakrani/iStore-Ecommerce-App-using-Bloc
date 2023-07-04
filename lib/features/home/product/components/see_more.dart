import 'package:flutter/material.dart';

class SeeMore extends StatefulWidget {
  final String productDescription;

  const SeeMore({super.key, required this.productDescription});

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Text(
              showMore
                  ? widget.productDescription
                  : "${widget.productDescription.substring(0,(( widget.productDescription.length~/2)))}...",
              maxLines: 3,
            ),
           
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
              onPressed: () {
                setState(() {
                  showMore = !showMore;
                });
              },
              child: Text(showMore ? "See less" : "See more")
            ),
        ),
      ],
    );
  }
}