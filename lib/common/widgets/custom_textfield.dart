import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxlines;
  final Icon icon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxlines=1,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    
    return TextFormField(

      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Your $hintText";
        }
        if (hintText == 'Email') {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(controller.text)) {
            return "Enter a Valid Email";
          }
        }
        else if (hintText == 'Password') {
          if (controller.text.length < 6) {
            return "Weak Password!";
          }
        }
        else if (hintText == 'Name') {
          if (controller.text.length < 3) {
            return "Try different Username";
          }
        }
        return null;
      },

      controller: controller,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
          prefixIconColor: Colors.black45,
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: height / 40,
              right: height / 50,
            ),
           child:icon,
          ),
          fillColor: GlobalVariables.greyBackgroundCOlor,
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(height / 60),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height / 60),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height / 50),
            borderSide: const BorderSide(
              color: Colors.orange,
            ),
          )),
      maxLines: maxlines,
    );
  }
}
