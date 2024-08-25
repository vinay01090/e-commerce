import 'dart:convert';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  Future<List<Order>> fetchOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> allOrders = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Token': userProvider.user.token,
        },
      );

      Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) {
        return [];
      }

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            allOrders.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    } 
    return allOrders; 
  }
}
