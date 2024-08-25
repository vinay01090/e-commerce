import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSubTotal extends StatelessWidget {
  const CardSubTotal({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: EdgeInsets.all(width /30),
      child: Row(
        children: [
          Text(
            'SubTotal : ',
            style: TextStyle(
              fontSize: width / 20,
            ),
          ),
          Text(
            '\$$sum',
            style:TextStyle(
              fontSize:width/18,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );
  }
}
