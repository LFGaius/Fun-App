
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/app_dawer.dart';
import 'package:funapp/widgets/publication_card.dart';
import 'package:funapp/widgets/publication_editor_card.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zefyr/zefyr.dart';

class HomePage extends StatefulWidget {
  BuildContext get homePageContext {
    return this.pageContext;
  }
  BuildContext pageContext;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey= new GlobalKey<ScaffoldState>();
  CollectionReference publications;

  NotusDocument _loadDocument(var content){
    return NotusDocument.fromJson(jsonDecode(content));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    publications = FirebaseFirestore.instance.collection('publications');
  }

  @override
  Widget build(BuildContext context) {
    widget.pageContext=context;//we store the context of this widget
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
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.86,
            child:StreamBuilder<QuerySnapshot>(
              stream: publications.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((
                      DocumentSnapshot document) {
                    // return PublicationCard(
                    //   title: 'title',
                    //   message: 'messsage',
                    // );
                        return PublicationEditorCard(
                                    readonly: true,
                                    creationDate: document.data()['creationDate']!=null? DateTime.parse(document.data()['creationDate'].toDate().toString()).toLocal().toString().split('.')[0]:'--/--/-- --:--',
                                    bodyctrl:ZefyrController(_loadDocument(document.data()['body'])) ,
                                    titlectrl:TextEditingController(text:document.data()['title']),
                                    focusNode: FocusNode(),
                                );
                      }).toList(),
                );
              }
            ),
            // child: ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   itemCount: 1,
            //   itemBuilder: (context, position) {
            //     return PublicationEditorCard(
            //         readonly: true,
            //         bodyctrl:ZefyrController(_loadDocument()) ,
            //         titlectrl:TextEditingController(text:'fsdfsdfsd'),
            //         focusNode: FocusNode(),
            //     );
            //   },
            // ),
          )

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
