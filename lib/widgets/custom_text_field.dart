import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';

class CustomTextField extends StatelessWidget {
  // This widget is the root of your application.

  final TextEditingController controller;
  final String hintText;
  final String label;
  final String errorMessage;
  final bool obscureText;
  final Icon icon;

  CustomTextField({this.label,this.controller,this.hintText,this.errorMessage,this.obscureText,this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex:1,
              child: Column(
                children: [
                  Text(
                      label,
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        color:ConfigDatas.appWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                  ),
                  errorMessage.isNotEmpty?
                    Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          color:Colors.red,
                          fontSize: 15,
                        )
                    )
                      :
                    SizedBox(height: 8,)
                ],
              ),
            )
          ],
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white54),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
            ),
            filled: true,
            fillColor: ConfigDatas.appWhiteColor
          ),

          obscureText: obscureText,
        ),
      ],
    );
  }
}