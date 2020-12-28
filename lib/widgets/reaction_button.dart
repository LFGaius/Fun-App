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
    CollectionReference publications = FirebaseFirestore.instance.collection('publications');
    CollectionReference reactions = FirebaseFirestore.instance.collection('reactions');
    SharedPreferences prefs=await SharedPreferences.getInstance();print('uid:${prefs.getString('fun_user_id')}');
    try {
      if(selected) {
        // WriteBatch batch = FirebaseFirestore.instance.batch();
        // reactions.where('publicationId', isEqualTo: publicationId)
        // .where('ownerId', isEqualTo: prefs.getString('fun_user_id')).get().then((querySnapshot) {
        //   querySnapshot.docs.forEach((document) {
        //     batch.delete(document.reference);
        //   });
        //   updateReactionNumberOnPublication(publications,-1);
        //   return batch.commit();
        // });
        await deleteExistingReaction(prefs,reactions);
        updateReactionNumberOnPublication(reactions,publications);
      }else {
        await deleteExistingReaction(prefs,reactions);
        await reactions.add({
        'publicationId': publicationId,
        'variant': variant,
        'ownerId': prefs.getString('fun_user_id')
        });
        updateReactionNumberOnPublication(reactions,publications);
      }

    }catch(error){
      Fluttertoast.showToast(
          msg : "Failed: $error",
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

  Future<void> deleteExistingReaction(SharedPreferences prefs,CollectionReference reactions) async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    QuerySnapshot querySnapshot=await reactions.where('publicationId', isEqualTo: publicationId)
      .where('ownerId', isEqualTo: prefs.getString('fun_user_id')).get();
      querySnapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
      return batch.commit();
  }

  updateReactionNumberOnPublication(CollectionReference reactions,CollectionReference publications) async{
    String otherVariant=variant=='like'?'unlike':'like';
    //NB these calculations shouldbe done using trigger. So, the logic below is temporary!
    QuerySnapshot querySnapshot=await reactions.where('variant', isEqualTo: variant)
                                               .where('publicationId', isEqualTo: publicationId).get();
    QuerySnapshot querySnapshot1=await reactions.where('variant', isEqualTo: otherVariant)
                                                .where('publicationId', isEqualTo: publicationId).get();
    publications.doc(publicationId)
        .update({
          '${variant}Number': querySnapshot.docs.length,
          '${otherVariant}Number': querySnapshot1.docs.length
        })
        .then((value) => print("pub Updated"))
        .catchError((error) => print("Failed to update pub: $error"));
  }
}