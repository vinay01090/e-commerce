import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: EdgeInsets.only(
        left: width / 80,
        right: width / 80,
        bottom: width / 80,
      ),
      child: Row(
        children: [
          SizedBox(
            height: height / 30,
            width: width / 20,
          ),
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
