
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/publication_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey= new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ConfigDatas.appWhiteColor,
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
            decoration: ConfigDatas.boxDecorationWithBackgroundGradientAppBar,
            height: MediaQuery.of(context).size.height*0.14,
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset(
                      "assets/menuicon.png",
                      height: MediaQuery.of(context).size.height*0.06,
                    ),
                  ),
                  Image.asset(
                    "assets/logo.png",
                    height: MediaQuery.of(context).size.height*0.06,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.86,
            width: MediaQuery.of(context).size.width*0.75,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, position) {
                return PublicationCard(
                  title: 'Title',
                  message: 'Rzeqtteqzt etqzte gfdgdfg sgfsdg fgds Tgdgsdf jhji jhjlkh hgk kjgjh ukyhjkuyg HGkjkl df g h j k kjk j klj !',
                );
              },
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/createpublication',
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: ConfigDatas.appGreenColor,
      ),
    );
  }
}
