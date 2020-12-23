import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:keyboard_utils/keyboard_listener.dart';
import 'package:keyboard_utils/keyboard_utils.dart';
import 'package:zefyr/zefyr.dart';

class PublicationEditorCard extends StatefulWidget{
  final String creationDate;
  final TextEditingController titlectrl;
  final ZefyrController bodyctrl;
  final bool readonly;
  final focusNode;

  const PublicationEditorCard({Key key, this.titlectrl, this.bodyctrl, this.focusNode, this.readonly, this.creationDate}) : super(key: key);

  @override
  _PublicationEditorCardState createState() => _PublicationEditorCardState();
}

class _PublicationEditorCardState extends State<PublicationEditorCard> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  double heightKeyBoard = 0.0;
  KeyboardUtils _keyboardUtils = KeyboardUtils();

  @override
  void initState() {
    super.initState();
    var _idKeyboardListener = _keyboardUtils.add(
        listener: KeyboardListener(willHideKeyboard: () {
          setState(() {
            heightKeyBoard = 0.0;
          });
        }, willShowKeyboard: (double keyboardHeight) {
          setState(() {
            heightKeyBoard = keyboardHeight;
          });
        }));
  }

  @override
  Widget build(context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.0),
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: widget.readonly?EdgeInsets.only(bottom:20.0):EdgeInsets.all(0.0),
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
                        heightKeyBoard==0.0?MediaQuery.of(context).size.height*0.5:MediaQuery.of(context).size.height*0.5-heightKeyBoard+MediaQuery.of(context).size.height*0.14,
                child: ZefyrScaffold(

                  child: ZefyrEditor(

                    mode: widget.readonly? ZefyrMode.view:ZefyrMode.edit,
                    // autofocus: false,
                    controller: widget.bodyctrl,
                    focusNode: widget.focusNode,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}