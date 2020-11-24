import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';

class PublicationCard extends StatelessWidget{

  final String title;
  final String message;

  PublicationCard({this.title,this.message});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '12/12/1231 12:32',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15.0,
                        color: ConfigDatas.publicationCardDateColor
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 4.0,bottom: 15.0),
                child: Text(
                  title,
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
                  '  ${message}',
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