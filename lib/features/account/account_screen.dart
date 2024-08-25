import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/belowappbar.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/topbutton.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height; 
    var width=MediaQuery.of(context).size.height; 
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height/10),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top:height/40),
                child: Image.asset(
                  'assets/images/amzn1.png',
                  width: width/5,
                  height: height/4,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: width/8,),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          SizedBox(height: height/20),
          const TopButtons(),
          SizedBox(height: height/20),
          const Orders(),
        ],
      ),
    );
  }
}