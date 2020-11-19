import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:funapp/routes/route_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${FlutterConfig.get('APP_NAME')}',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: MyRouteBuilder.buidRoute
    );
  }
}