
import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/app_dawer.dart';
import 'package:funapp/widgets/publication_editor_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' as io;
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zefyr/zefyr.dart';
// import 'package:pakle/afri_spinner.dart';

class NewPublicationPage extends StatefulWidget {

  @override
  _NewPublicationPageState createState() => _NewPublicationPageState();
}

class _NewPublicationPageState extends State<NewPublicationPage> {
  GlobalKey<ScaffoldState> scaffoldKey= new GlobalKey<ScaffoldState>();
  TextEditingController titlectrl=new TextEditingController();
  ZefyrController bodyctrl;
  var focusNode=FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final document=_loadDocument();
    bodyctrl=ZefyrController(document);
  }

  NotusDocument _loadDocument(){
    final Delta delta=Delta()..insert("Your text content here\n");
    return NotusDocument.fromDelta(delta);
  }

  publish() async{

    CollectionReference publications = FirebaseFirestore.instance.collection('publications');
    SharedPreferences prefs=await SharedPreferences.getInstance();print('title:${titlectrl.text} uid:${prefs.getString('fun_user_id')}');
    publications.add({
      'creationDate': (new DateTime.now()).toUtc(), // John Doe
      'title': titlectrl.text,
      'body': jsonEncode(bodyctrl.document),
      'ownerId': prefs.getString('fun_user_id')
    })
        .then((value)=>{
          Fluttertoast.showToast(
            msg: "Publication Created!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
          ),
          Navigator.of(context).pushReplacementNamed(
          '/home',
          )
        })
        .catchError((error) => Fluttertoast.showToast(
            msg: "Failed to add publication: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ConfigDatas.publicationCardBackground,
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
            // decoration: BoxDecoration(
            //   color: Color.fromRGBO(76, 131, 47, 0.9),
            // ),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.08,
            child: Icon(
              Icons.note_add,
              size: MediaQuery.of(context).size.height*0.08,
              color: ConfigDatas.appWhiteColor,
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.6,
            child: PublicationEditorCard(
              readonly: false,
              bodyctrl:bodyctrl ,
              titlectrl:titlectrl ,
              focusNode:focusNode
            )
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.14,
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
                onPressed: publish,
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