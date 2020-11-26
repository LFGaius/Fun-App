
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/app_dawer.dart';
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
      drawer: AppDawer(),
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
