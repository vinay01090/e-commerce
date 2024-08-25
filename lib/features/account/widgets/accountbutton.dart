import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text; 
  const AccountButton({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height; 
    var width=MediaQuery.of(context).size.width; 
    return Container(
      height:height/17,
      width:width/2.5,
      margin:EdgeInsets.symmetric(horizontal: height/60),
      decoration:  BoxDecoration(
        color: GlobalVariables.greyBackgroundCOlor.withOpacity(0.05),
        borderRadius: BorderRadius.all(Radius.circular(height/2),
        ),
      ),
      child:OutlinedButton(
        onPressed: (){},
         style: ElevatedButton.styleFrom(
           backgroundColor: GlobalVariables.backgroundColor.withOpacity(0.03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height/2),
          ),
          side: const BorderSide(
            color: Color.fromARGB(255, 141, 138, 138),),
         ),
         child: Text(text),
         ),
      
      );
  }
}