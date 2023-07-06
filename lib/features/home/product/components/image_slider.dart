import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imagePaths;

  const ImageSlider({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imagePaths.length,
      itemBuilder: (context, index, _) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade100,
          ),
          padding: const EdgeInsets.all(16),
          child: Image.asset(
            imagePaths[index],
          ),
        );
      },
      options: CarouselOptions(
        height: 200, // Set the desired height of the slider
        viewportFraction: 0.6, // Set the visible fraction of each item
        enableInfiniteScroll: true, // Allow infinite scrolling
        autoPlay: true, // Enable auto play
      ),
    );
  }
}
