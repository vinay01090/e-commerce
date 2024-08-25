import 'dart:convert';
import 'package:amazon_clone/constants/Utils.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/features/auth/services/provider_service.dart';
import 'package:amazon_clone/features/home/screen/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:provider/provider.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 

class AuthService {

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async{
    try{
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart:[],
      );

      http.Response response=await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      
      await Future.delayed(const Duration(seconds: 1)); 
      if(!context.mounted){
        return; 
      }

      httpErrorHandler(context: context, response: response,
      onSuccess: (){
        showSnackBar(context,'Account created! Login with the same credentials!'); 
      },
      ); 
    }
    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
    }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      await Future.delayed(const Duration(seconds:1)); 

      if(!context.mounted){
        return; 
      }

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: ()async{
  
          showSnackBar(context, 'Welcome Back!'); 

          SharedPreferences sharedPrefrences=await SharedPreferences.getInstance(); 

          await Future.delayed(const Duration(seconds:1)); 

          if(!context.mounted){
            return; 
          }

          Provider.of<UserProvider>(context,listen:false).setUser(response.body);
          await sharedPrefrences.setString('Token',jsonDecode(response.body)['token']); 

          await Future.delayed(const Duration(seconds:1)); 
          if(!context.mounted){
            return; 
          }

          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false); 
        }

        ); 
    }
    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void fetchUserData(BuildContext context) async{

    try{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    String? token=sharedPreferences.getString('Token'); 

     

    if(token==null){
      sharedPreferences.setString('Token',''); 
    }

    var tokenRes=await http.post(Uri.parse("$uri/validateToken"),
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Token':token!,
      }
    ); 



    var response= jsonDecode(tokenRes.body); 

    if(response==true){
      http.Response userResponse=await http.get(Uri.parse("$uri/"),
       headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Token':token,
          }
      ); 

      // ignore: use_build_context_synchronously
      var userProvider=Provider.of<UserProvider>(context,listen:false); 
      userProvider.setUser(userResponse.body); 
    }

    }
    catch(e){

      await Future.delayed(const Duration(seconds:1)); 
          if(!context.mounted){
            return; 
      }

      showSnackBar(context, e.toString());   
    }
   
  }
}