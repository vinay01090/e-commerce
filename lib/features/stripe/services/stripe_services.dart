import 'dart:convert';
import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

  Future createPaymentIntent({
    required String amount, 
    required String currency
    })async {
     try {
       final body = {
        'amount': amount,
        'currency': currency,
       };

      http.Response res = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51PbJXUAavzVbAJDfI8E0vL6h3FIO00dGyk7f1xPiK1jZTLgH0peZg1lTEw4ycVCZXK9Yx8WE93sgqk6mdvGyLXyQ00O7llED8M',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
    } catch (e) {
      throw ("Error in calling a paymentIntent"); 
    }
  }



  Future<void> initPaymentSheet({
    required int tAmount,
    required String currency,
    required BuildContext context,
  }) async{

  try{
    final data=await createPaymentIntent(
      amount: tAmount.toString(),
      currency: "USD",
    ); 
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: false,
        merchantDisplayName: "vinay",
        paymentIntentClientSecret: data['client_secret'],
        customerEphemeralKeySecret: data['ephemeralKey'],
        customerId: data['id'],
        style: ThemeMode.dark,
      )
    ); 
  }
  catch(e){
     Future.delayed(const Duration(seconds: 1)); 
     if(!context.mounted){
      return; 
     }
      showSnackBar(context,e.toString()); 
  }
 }
