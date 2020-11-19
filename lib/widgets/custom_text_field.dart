import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // This widget is the root of your application.

  final TextEditingController controller;
  final String hintText;
  final String errorMessage;
  final bool obscureText;
  final Icon icon;

  CustomTextField({this.controller,this.hintText,this.errorMessage,this.obscureText,this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex:1,
              child: Container(
                padding: EdgeInsets.only(top:3),
                child: Text(
                    errorMessage,
                    textAlign: TextAlign.left,
                    style:TextStyle(
                      color:Colors.red,
                      fontSize: 9,
                    )
                ),
              ),
            )
          ],
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(

            prefixIcon: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(10)
                ),
                child: icon
            ),

            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none
            ),

            filled: true,
            fillColor: Color.fromRGBO(27, 34, 50, 0.1),
          ),

          obscureText: obscureText,
        ),
      ],
    );
  }
}