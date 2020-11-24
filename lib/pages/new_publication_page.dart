
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' as io;
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pakle/afri_spinner.dart';

class NewPublicationPage extends StatefulWidget {

  @override
  _NewPublicationPageState createState() => _NewPublicationPageState();
}

class _NewPublicationPageState extends State<NewPublicationPage> {

  // @override
  // void initState(){
  // }
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
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.16,
            child: Text(
              'NEW PUBLICATION',
              style: TextStyle(
                color: ConfigDatas.publicationCardDateColor,
                fontSize: 30,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width*0.75,
            child: PublicationEditorCard(
                  title: 'title',
                  message: 'Rzeqtteqzt etqzte gfdgdfg sgfsdg fgds Tgdgsdf jhji jhjlkh hgk kjgjh ukyhjkuyg HGkjkl df g h j k kjk j klj !',
                )
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.2,
            child: SizedBox(
              width:MediaQuery.of(context).size.width*0.55,
              child: RaisedButton(
                color: ConfigDatas.appGreenColor,
                padding: EdgeInsets.all(20),
                elevation: 5,
                child: Text(
                  'PUBLISH',
                  style: TextStyle(
                      color: ConfigDatas.appWhiteColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900
                  ),
                ),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/home',
          );
        },
        child: Icon(
          Icons.home,
          size: 30,
        ),
        backgroundColor: ConfigDatas.appGreenColor,
      ),
    );
  }

}

class PublicationEditorCard extends StatelessWidget{

  final String title;
  final String message;

  PublicationEditorCard({this.title,this.message});


  @override
  Widget build(context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.only(bottom: 30.0),
      color: ConfigDatas.publicationCardBackground,
      elevation: 5,
      child: Padding(
          padding: EdgeInsets.only(top: 4.0,left: 20.0,right: 20.0,bottom: 15.0),
          child: Column(
            children: [

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 20.0,bottom: 15.0),
                child: Text(
                  'title',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30.0,
                      color: ConfigDatas.appWhiteColor
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 4.0,bottom: 15.0),
                child: Text(
                  'hdfghdghfdh',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                      color: ConfigDatas.appWhiteColor
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}