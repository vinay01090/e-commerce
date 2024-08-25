import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_detail_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  final AccountServices accountServices=AccountServices(); 
  List<Order>? orders; 

  @override
  void initState(){
    super.initState(); 
    fetchOrders(); 
  }

  void fetchOrders() async{
     orders=await accountServices.fetchOrders(context: context); 
     setState((){}); 
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height; 
    return orders==null?
    const Loader():
    Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: width / 17),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: width / 2.3,
            ),
            const Text('Seeall',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 7, 52, 129),
                )),
          ],
        ),
        SizedBox(height: height/50,),
        Container(
          height:height/6,
          margin:EdgeInsets.only(left:width/60),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap:(){
                  Navigator.pushNamed(
                    context,
                    OrderDetailScreen.routeName,
                    arguments: orders![index],
                    );
                },
                child: SingleProduct(
                  image: orders![index].products[0].images[0],
                  ),
              );
            },
          ),
        ),
      ],
    );
  }
}
