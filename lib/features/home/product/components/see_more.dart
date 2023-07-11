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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              showMore
                  ? widget.productDescription
                  : "${widget.productDescription.substring(0, ((widget.productDescription.length ~/ 2)))}...",
              maxLines: showMore ? null:3,
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showMore = !showMore;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    showMore ? "See less" : "See more",

                    style: TextStyle(
                      color: Colors.purple.shade800,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
