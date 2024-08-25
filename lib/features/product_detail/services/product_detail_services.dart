import 'dart:convert';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) {
        return;
      }

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    http.Response res = await http.post(
      Uri.parse('$uri/api/add-to-cart'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Token': userProvider.user.token,
      },
      body: jsonEncode({
        'id': product.id!,
      }),
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
            cart: jsonDecode(res.body)['cart'],
          );

          userProvider.setUserfromModel(user);
        });

    try {} catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
