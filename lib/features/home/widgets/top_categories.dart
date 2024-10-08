import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screen/categorydeals_screen.dart';
import 'package:flutter/material.dart';

// class TopCategories extends StatelessWidget {
//   const TopCategories({super.key});

//   void navigateToPage(BuildContext context, String category) {
//     Navigator.pushNamed(context, CategoryDeals.routeName, arguments: category);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: GlobalVariables.categoryImages.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => navigateToPage(
//                         context, GlobalVariables.categoryImages[index]['title']!),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.asset(
//                       GlobalVariables.categoryImages[index]['image']!,
//                       fit: BoxFit.cover,
//                       height: 50,
//                       width: 50,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   GlobalVariables.categoryImages[index]['title']!,
//                   style: const TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context,String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName, 
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
              context,
              GlobalVariables.categoryImages[index]['title']!,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class TopCategories extends StatelessWidget {
//   const TopCategories({Key? key}) : super(key: key);

//   void navigateToCategoryPage(BuildContext context, String category) {
//     Navigator.pushNamed(context, CategoryDealsScreen.routeName,
//         arguments: category);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       child: ListView.builder(
//         itemCount: GlobalVariables.categoryImages.length,
//         scrollDirection: Axis.horizontal,
//         itemExtent: 75,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () => navigateToCategoryPage(
//               context,
//               GlobalVariables.categoryImages[index]['title']!,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.asset(
//                       GlobalVariables.categoryImages[index]['image']!,
//                       fit: BoxFit.cover,
//                       height: 40,
//                       width: 40,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   GlobalVariables.categoryImages[index]['title']!,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
