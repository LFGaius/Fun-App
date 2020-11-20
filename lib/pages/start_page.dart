
import 'dart:async';
import 'dart:io';

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
          prefs.setBool('fun_already_opened',null);
          if(prefs.getBool('fun_already_opened')==null){//first time connection
            SharedPreferences prefs=await SharedPreferences.getInstance();
            prefs.setBool('fun_already_opened',true);
            Navigator.of(context).popAndPushNamed(
              '/onboarding',
            );
          }else{
            if(prefs.getBool('fun_is_login')==null || prefs.getBool('fun_is_login')==false)
              Navigator.of(context).popAndPushNamed(
                '/login',
              );
            else{
              Navigator.of(context).pushNamed(
                  '/home'
              );
            }
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