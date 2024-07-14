import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,required this.hintText, this.onChange,this.obscureText=false});

  Function(String)? onChange;
   String? hintText;
   bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText! ,
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      onChanged:onChange ,
      decoration: InputDecoration(
          hintText: hintText,
           hintStyle:const TextStyle(
              color: Colors.white
           ),
          enabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(
                color: Colors.white
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        border: OutlineInputBorder(
          borderSide:const BorderSide(
              color: Colors.white
          ),
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
  }
}
