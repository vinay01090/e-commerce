// import 'package:amazon_clone/features/auth/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badge;

// class BottomNavBar extends StatefulWidget {
//   static const String routeName = '/bottomNavScreen';
//   const BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   List<Widget> pages = [
//     const HomeScreen(),
//     const Center(child:Text('hell0')),
//     const Center(
//       child:Text('Cart'),
//       ),
//   ];

//   int _ind = 0;

//   void updatePages(int ind) {
//     setState(() {
//       _ind = ind;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _ind,
//         onTap: updatePages,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_box),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: badge.Badge(
//               badgeContent: Text('2'),
//               child: Icon(Icons.shopping_cart_outlined),
//             ),
//             label: '',
//           ),
//         ],
//       ),
//       body: pages[_ind],
//     );
//   }
// }
