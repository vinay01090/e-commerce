import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/homeservices.dart';
import 'package:amazon_clone/features/product_detail/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealofTheDay extends StatefulWidget {
  final double height;
  const DealofTheDay({super.key, required this.height});

  @override
  State<DealofTheDay> createState() => _DealofTheDayState();
}

class _DealofTheDayState extends State<DealofTheDay> {

  final HomeServices homeServices=HomeServices(); 
  Product ?product; 

  @override
  void initState(){
    super.initState(); 
    dealOftheday(); 
  }

  dealOftheday() async{
     product=await homeServices.dealOftheday(context: context); 
     setState(() {});
  }

  void navigateToProductDetailScreen(){
    Navigator.pushNamed(context,ProductDetailScreen.routeName,arguments:product); 
  }

  @override
  Widget build(BuildContext context) {
    return product==null?const Loader():
    product!.name.isEmpty? const SizedBox():
    Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            top: widget.height / 30,
            left: widget.height / 20,
          ),
          child: Text(
            'Deal of the day',
            style: TextStyle(
              fontSize: widget.height / 14,
            ),
          ),
        ),
        SizedBox(
          height: widget.height/15,
        ),
        GestureDetector(
          onTap:navigateToProductDetailScreen,
          child: Image.network(
            product!.images[0],
            fit: BoxFit.fitHeight,
            height:widget.height,
            width: 500,
          ),
        ),
        SizedBox(
          height: widget.height / 20,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            '\$100',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Rivaan',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          height: widget.height / 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: widget.height / 50,
              ),
              Container(
                margin: EdgeInsets.only(left: widget.height / 50),
                child: Image.network(
                  'https://images.unsplash.com/photo-1719228324632-39312a4cd1fd?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHwzNHx8fGVufDB8fHx8fA%3D%3D',
                  width: widget.height / 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: widget.height / 50),
                child: Image.network(
                  'https://images.unsplash.com/photo-1719228324632-39312a4cd1fd?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHwzNHx8fGVufDB8fHx8fA%3D%3D',
                  width: widget.height / 1.2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: widget.height / 50),
                child: Image.network(
                  'https://images.unsplash.com/photo-1719228324632-39312a4cd1fd?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHwzNHx8fGVufDB8fHx8fA%3D%3D',
                  width: widget.height / 1.2,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
