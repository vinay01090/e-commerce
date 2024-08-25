import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/account_screen.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/cart/screen/cart_screen.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart'as badge;
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _ind = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int ind) {
    setState(() {
      _ind = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartLen=context.watch<UserProvider>().user.cart.length; 
    var height=MediaQuery.of(context).size.height; 
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: height/35,
        currentIndex: _ind,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _ind == 0
                        ? Colors.orange
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.home_mini_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _ind == 1
                        ? Colors.orange
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child: const Icon(Icons.account_box_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _ind == 2
                        ? Colors.orange
                        : GlobalVariables.backgroundColor,
                  ),
                ),
              ),
              child:badge.Badge(
                badgeContent: Text(cartLen.toString()),
                child: const  Icon(Icons.add_shopping_cart_rounded)),
            ),
            label: '',
          ),
        ],
      ),
      body: pages[_ind],
    );
  }
}
