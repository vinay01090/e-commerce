import 'package:amazon_clone/features/account/widgets/accountbutton.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
            ),
            AccountButton(
              text: 'Turn Seller',
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
            ),
            AccountButton(
              text: 'Your Wish List',
            ),
          ],
        ),
      ],
    );
  }
}