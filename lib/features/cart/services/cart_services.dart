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

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
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
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
