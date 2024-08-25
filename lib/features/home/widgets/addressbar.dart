import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBar extends StatelessWidget {
  final double height;
  const AddressBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 253, 187, 100),
            Color.fromARGB(255, 247, 163, 73),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: EdgeInsets.only(left: height / 1.5),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 28,
          ),
          Expanded(
            child: Padding(
               padding:EdgeInsets.only(left:height/3),
               child: Text(
                'Delivery to ${user.name} - ${user.address}',
                style:const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top:height/100,
              right:height/2,
              ),
              child:const Icon(
                Icons.arrow_drop_down_outlined,
                size:25,
                ),
              ),
        ],
      ),
    );
  }
}
