
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
    Timer(Duration(seconds: 4),() {
      Jobs.getUserPreferences().then((SharedPreferences prefs) async{
          errormessage='';
          if(prefs.getBool('fun_already_opened')==null){//first time connection
            SharedPreferences prefs=await SharedPreferences.getInstance();
            prefs.setBool('fun_already_opened',true);
            Navigator.of(context).popAndPushNamed(
              '/onboarding',
            );
          }else{//TO DO:manage here shared preferences(Navigations will be handled on the trigger widgets)
            if(prefs.getBool('fun_is_logged_in')==null || !prefs.getBool('fun_is_logged_in'))
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            else
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

            FirebaseAuth.instance
                .authStateChanges()
                .listen((User user) async{
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  print('listened');
                  if (user == null) {
                    prefs.setBool('fun_is_logged_in', false);
                  }else
                    prefs.setBool('fun_is_logged_in',true);
            });
          }

      });
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