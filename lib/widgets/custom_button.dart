import 'dart:ui';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
    CustomButton({super.key, this.ontap,required this.text});
   String text;
   VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:ontap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child:  Text(
          text,
          style: const TextStyle(fontSize: 20,),
        ),
      ),
    );
  }
}
