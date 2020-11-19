
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 218, 0, 1),
      appBar:AppBar(
        elevation:25.0,
        backgroundColor: Color.fromRGBO(27, 34, 50, 1),
        // title: Text('home'),
        iconTheme: IconThemeData(color: Color.fromRGBO(250, 218, 0, 1)),
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right:8),
        //     child: Image.asset(
        //       "assets/pakle.jpg",
        //       width: MediaQuery.of(context).size.height*0.15,

        //     ),
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(250, 218, 0, 1),
          child: ListView(
            padding: EdgeInsets.zero,
            children:  <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/backheaddawer.png'),
                        fit: BoxFit.fill
                    ),
                    color: Color.fromRGBO(27, 34, 50, 1),
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
                              color: Color.fromRGBO(250, 218, 0, 1),
                              size: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Gaius',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(250, 218, 0, 1),
                                    fontSize:16,
                                  ),
                                ),
                                Text(
                                  'lib@gmail.com',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(250, 218, 0, 1),
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
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'My Network',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.insert_chart,
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'Reports',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'Settings & Security',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person_pin,
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'Invite Your Friends',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.cancel,
                  color:Color.fromRGBO(27, 34, 50, 0.9),
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color:Color.fromRGBO(27, 34, 50, 1)
                  ),
                ),
                onTap: () async{
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  prefs.setString('pakle_email',null);
                  prefs.setBool('pakle_is_login',false);
                  exit(0);
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height*0.35,
              decoration:BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/hometop.png'),
                      fit: BoxFit.fill
                  )
              )
          ),
          Center(
            child: Text(
              'You want to ?',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:Color.fromRGBO(27, 34, 50, 1)
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomCard(
                imagepath: 'assets/learn.png',
                message: 'LEARN',
              ),
              CustomCard(
                imagepath: 'assets/teach.png',
                message: 'CREATE/EDIT',
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget{

  final String imagepath;
  final String message;

  CustomCard({this.imagepath,this.message});

  @override
  Widget build(context){
    return FlatButton(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                spreadRadius: 0.4,
                offset: Offset(0,4),
                color: Color.fromRGBO(27, 34, 50, 1)
            )
          ],
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(27, 34, 50, 0.98),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.24,
              width: MediaQuery.of(context).size.width*0.40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 218, 0, 1),
                image: DecorationImage(
                  image: AssetImage(imagepath),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height*0.09,
                width: MediaQuery.of(context).size.width*0.40,
                child:Center(
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Color.fromRGBO(250, 218, 0, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      onPressed: () {
        switch(message){
          case 'LEARN':
            break;
          case 'CREATE':
            break;
        }
      },
    );
  }
}
