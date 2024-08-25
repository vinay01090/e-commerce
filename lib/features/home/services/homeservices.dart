import 'dart:convert';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context,listen:false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
      );
      Future.delayed(const Duration(seconds: 1));
      if(!context.mounted){
        return []; 
      }

      httpErrorHandler(
        context: context, 
        response: res,
         onSuccess: (){
          for(int i=0; i<jsonDecode(res.body).length; i++){
             productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                )
              )
             ); 
          }
         }); 
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList; 
  }
   Future<Product> dealOftheday({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      images: [],
      quantity: 0,
      price: 0,
      category: '',
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/deal-of-the-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
      );

      Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) {
        return product;
      }

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return product;
  }
}