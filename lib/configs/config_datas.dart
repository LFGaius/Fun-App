import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ConfigDatas{
  static final Color pageBackgroundColor1=Color.fromRGBO(138, 203, 90, 1);
  static final Color pageBackgroundColor2=Color.fromRGBO(169, 249, 115, 1);
  static final Color appWhiteColor=Color.fromRGBO(249, 249, 249, 1);
  static final Color appGreenColor=Color.fromRGBO(142, 213, 98, 1);
  static final Color loginFlowButtonColor=Color.fromRGBO(255, 204, 65, 1);
  static final Color publicationCardBackground=Color.fromRGBO(255, 198, 42, 1);
  static final Color publicationCardDateColor=Color.fromRGBO(86, 86, 86, 1);
  static final BoxDecoration boxDecorationWithBackgroundGradient= BoxDecoration(
    gradient: new LinearGradient(colors: [ConfigDatas.pageBackgroundColor1,ConfigDatas.pageBackgroundColor2 ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.0,1],
        tileMode: TileMode.clamp
    ),
  );
  static final BoxDecoration boxDecorationWithBackgroundGradientAppBar= BoxDecoration(
    gradient: new LinearGradient(colors: [Color.fromRGBO(119, 204, 96, 1),Color.fromRGBO(142, 213, 98, 1) ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.0,1],
        tileMode: TileMode.clamp
    ),
  );
}