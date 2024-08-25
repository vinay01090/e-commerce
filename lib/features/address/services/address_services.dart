import 'dart:convert';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/update-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'address': address,
          },
        ),
      );

      Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) {
        return;
      }

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserfromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required int totalSum,
  })async{
    final userProvider=Provider.of<UserProvider>(context,listen:false); 
    try{

       http.Response res= await http.post(Uri.parse('$uri/api/order'),
       headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'cart':userProvider.user.cart,
            'address':address,
            'totalPrice':totalSum,
          },
        ),
      );

      Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) {
        return;
      }

      httpErrorHandler(
        context: context, 
        response: res, 
        onSuccess: (){
          User user=userProvider.user.copyWith(
            cart:[],
          ); 
          userProvider.setUserfromModel(user); 
          showSnackBar(context, 'Your order has been Placed'); 
        }
        ); 

    }
    catch(e){
      showSnackBar(context,e.toString()); 
    }
  }
}
