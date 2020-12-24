import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReactionButton extends StatelessWidget{

  final String variant;
  final bool selected;
  final String publicationId;
  final Widget totalText;

  ReactionButton({this.selected,this.publicationId, this.variant, this.totalText});

  @override
  Widget build(context){
    return Column(
      children: [
        GestureDetector(
          onTap: saveReaction,
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color:Color.fromRGBO(0, 0, 0, 0.3),
                      offset: Offset(0,4)
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                color: selected?ConfigDatas.publicationCardBackground:Colors.white
            ),
            child: Image.asset(
              variant=='like'?"assets/thumb_up.png":"assets/thumb_down.png",
            ),
          ),
        ),
        SizedBox(height: 5,),
        totalText
      ],
    );
  }

  saveReaction() async{
    CollectionReference reactions = FirebaseFirestore.instance.collection('reactions');
    SharedPreferences prefs=await SharedPreferences.getInstance();print('uid:${prefs.getString('fun_user_id')}');
    try {
      await reactions.add({
        'publicationId': publicationId,
        'variant': variant,
        'ownerId': prefs.getString('fun_user_id')
      });
    }catch(error){
      Fluttertoast.showToast(
          msg : "Failed to add publication: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    //     .then((value)=>{
    //   Fluttertoast.showToast(
    //       msg: "Publication Created!",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.green,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   ),
    //   Navigator.of(context).pushReplacementNamed(
    //     '/home',
    //   )
    // })
    //     .catchError((error) => Fluttertoast.showToast(
    //     msg: "Failed to add publication: $error",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // ));
  }
}