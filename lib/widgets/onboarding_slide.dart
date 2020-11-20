import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';

class OnboardingSlide extends StatelessWidget {
  final String imagepath;
  final String message;
  OnboardingSlide({this.imagepath,this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: Image.asset(
              imagepath,
              height: MediaQuery.of(context).size.height*0.4,
              width: MediaQuery.of(context).size.width*0.75,
            )
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.05),
        Container(
          padding: EdgeInsets.symmetric(horizontal:40),
          child:Text(
            message,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: ConfigDatas.appWhiteColor
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}