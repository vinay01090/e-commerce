import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width / 90),
      padding: EdgeInsets.all(width / 120),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: width / 2,
          ),
          borderRadius: BorderRadius.circular(height / 120),
          color: Colors.black12,
        ),
        child: Container(
          width: width / 4,
          padding: EdgeInsets.all(height / 250),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: width / 4,
          ),
        ),
      ),
    );
  }
}
