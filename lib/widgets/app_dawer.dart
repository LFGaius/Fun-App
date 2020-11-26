import 'dart:io';

import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ConfigDatas.appWhiteColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  color: ConfigDatas.appGreenColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(

                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            color: ConfigDatas.appWhiteColor,
                            size: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Gaius',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ConfigDatas.appWhiteColor,
                                  fontSize:16,
                                ),
                              ),
                              Text(
                                'lib@gmail.com',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ConfigDatas.appWhiteColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          )
                        ],
                      ), onPressed: () {
                      Navigator.of(context).pushNamed(
                          '/profile'
                      );
                    },
                    )
                  ],
                )
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'My Network',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.insert_chart,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'Reports',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'Settings & Security',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'Help',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_pin,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'Invite Your Friends',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.cancel,
                color:Color.fromRGBO(76, 131, 47, 0.9),
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                    color:Color.fromRGBO(76, 131, 47, 0.9)
                ),
              ),
              onTap: () async{
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setString('fun_email',null);
                prefs.setBool('fun_is_login',false);
                exit(0);
              },
            ),
          ],
        ),
      ),
    );
  }
}