import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zefyr/zefyr.dart';

import 'reaction_button.dart';

class PublicationEditorCard extends StatefulWidget{
  final int likenumber;
  final int unlikenumber;
  final String publicationId;
  final String creationDate;
  final TextEditingController titlectrl;
  final ZefyrController bodyctrl;
  final heightKeyBoard;
  final bool readonly;
  final focusNode;

  const PublicationEditorCard({Key key, this.titlectrl, this.bodyctrl, this.focusNode, this.readonly, this.creationDate, this.heightKeyBoard, this.publicationId, this.likenumber, this.unlikenumber}) : super(key: key);

  @override
  _PublicationEditorCardState createState() => _PublicationEditorCardState();
}

class _PublicationEditorCardState extends State<PublicationEditorCard> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  CollectionReference reactions;
  bool thumbUpSelected=false;
  bool thumbDownSelected=false;

  checkReaction(variant) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    CollectionReference reactions = FirebaseFirestore.instance.collection('reactions');
    QuerySnapshot querySnapshot=await reactions.where('variant', isEqualTo: variant)
        .where('ownerId', isEqualTo: prefs.getString('fun_user_id'))
        .where('publicationId', isEqualTo: widget.publicationId).get();
    if(mounted && (thumbUpSelected!=(querySnapshot.docs.length>0) || thumbDownSelected!=(querySnapshot.docs.length>0)))
      setState(() {
        if(variant=='like') thumbUpSelected=querySnapshot.docs.length>0;
        if(variant=='unlike') thumbDownSelected=querySnapshot.docs.length>0;
      });
    // print('variant $variant thumbUpSelected $thumbUpSelected - thumbDownSelected $thumbDownSelected-- ${querySnapshot.docs.toString()}');
  }

  @override
  void initState(){
    super.initState();
    print('-------init-------');

    // reactions = FirebaseFirestore.instance.collection('reactions').where('publicationId', isEqualTo:widget.publicationId);
    // StreamBuilder<QuerySnapshot>(
    //     stream: reactions.snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       print('------------${snapshot.data.docs.toString()}');
    //       return null;
    //     }
    // );
  }



  @override
  Widget build(context) {
    checkReaction('unlike');
    checkReaction('like');
    return Column(
      children: [
        Card(
          elevation: widget.readonly? 5:0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15.0),
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: widget.readonly?EdgeInsets.only(bottom:5.0):EdgeInsets.all(0.0),
          color: ConfigDatas.publicationCardBackground,
          child: Scrollbar(
            child: ListView(
              physics: widget.readonly?NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                if(widget.readonly) Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:8.0,right:8.0),
                      child: Text(
                        widget.creationDate,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                            color: ConfigDatas.publicationCardDateColor
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    readOnly: widget.readonly,
                    controller: widget.titlectrl,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: widget.readonly? InputBorder.none:const UnderlineInputBorder(),
                      hintText: 'Enter a title',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30.0,
                          color: Color.fromRGBO(255, 255, 255, 0.7)
                      ),
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30.0,
                        color: ConfigDatas.appWhiteColor
                    ),
                  ),
                ),
                Container(
                  // constraints: BoxConstraints(
                  //     minHeight: 50, minWidth: double.infinity, maxHeight: 400
                  // ),
                    height: widget.readonly?
                            widget.bodyctrl.document.length.toDouble()+50
                            :
                            widget.heightKeyBoard==0.0?MediaQuery.of(context).size.height*0.5 : MediaQuery.of(context).size.height*0.5-widget.heightKeyBoard+MediaQuery.of(context).size.height*0.14,
                    child: ZefyrScaffold(
                      child: ZefyrEditor(
                        mode: widget.readonly? ZefyrMode.view:ZefyrMode.edit,
                        autofocus: !widget.readonly,
                        controller: widget.bodyctrl,
                        focusNode: widget.focusNode,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
        if(widget.readonly) Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReactionButton(
              variant: 'like',
              selected: thumbUpSelected,
              publicationId: widget.publicationId,
              totalText:Text("${widget.likenumber}")
            ),
            ReactionButton(
              variant: 'unlike',
              selected: thumbDownSelected,
              publicationId: widget.publicationId,
              totalText:Text('${widget.unlikenumber}')
            )
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}