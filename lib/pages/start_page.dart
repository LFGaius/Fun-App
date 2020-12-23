
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/helpers/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  String errormessage='';

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 4),() async{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      errormessage='';
      if(prefs.getBool('fun_already_opened')==null){//first time connection
        prefs.setBool('fun_already_opened',true);
        Navigator.of(context).popAndPushNamed(
          '/onboarding',
        );
      }else{//TO DO:manage here shared preferences(Navigations will be handled on the trigger widgets)
        if(prefs.getString('fun_user_id')==null)
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        else
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
        FirebaseAuth.instance
            .authStateChanges()
            .listen((User user) async{
              SharedPreferences prefs=await SharedPreferences.getInstance();
              if (user == null) {
                print('(((((((disconnected------------');
                prefs.setString('fun_user_id', null);
              }else
                prefs.setString('fun_user_id', user.uid);});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: ConfigDatas.boxDecorationWithBackgroundGradient,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                    "assets/logo.png",
                    width: MediaQuery.of(context).size.height*0.35
                ),
              ],
            ),
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  // setActionPending(value){
  //   setState(() {
  //     actionpending=value;
  //   });
  // }
}