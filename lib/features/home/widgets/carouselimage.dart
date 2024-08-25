import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final double height;
  final double width;
  const CarouselImage({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            i,
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
      ),
    );
  }
}
