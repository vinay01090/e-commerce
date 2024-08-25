import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/Admin/productscreen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Widget> pages = [
    const ProductScreen(),
    const Text('Hello2'),
    const Text('hhh'),
  ];

  int _ind = 0;

  void updatePage(int ind) {
    setState(() {
      _ind = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height; 
    var width=MediaQuery.of(context).size.width; 
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height/13),
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
                  width: width/2.3,
                  height: height/3,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: width/8),

              Container(
                padding:EdgeInsets.only(top: height/30),
                child:Text('Admin',
                style:TextStyle(
                  fontSize:width/20,
                  color:Colors.black,
                )),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: height/32,
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
              child: const Icon(Icons.home_max_outlined),
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
              child: const Icon(Icons.analytics_rounded),
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
              child: const Icon(Icons.all_inbox_rounded),
            ),
            label: '',
          ),
        ],
      ),
      body: pages[_ind],
    );
}
}
