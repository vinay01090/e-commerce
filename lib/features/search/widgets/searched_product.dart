import 'package:amazon_clone/constants/ratings.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double totalRating=0; 
    for(int i=0; i<product.rating!.length; i++){
      totalRating+=product.rating![i].rating; 
    }
    double avgRating=0; 
    if(totalRating!=0){
      avgRating=totalRating/product.rating!.length; 
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: width / 50),
          child: Row(
            children: [
              Image.network(product.images[0],
                  fit: BoxFit.fitHeight, height: height / 7, width: width / 4),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height/100,left:width/20),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding:EdgeInsets.only(left:width/20,top:height/100,),
                    child:Stars(
                      rating:avgRating,
                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
