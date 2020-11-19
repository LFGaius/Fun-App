import 'package:flutter/material.dart';
import 'package:funapp/pages/home_page.dart';
import 'package:funapp/pages/login_page.dart';
import 'package:funapp/pages/new_publication_page.dart';
import 'package:funapp/pages/onboarding_screen.dart';
import 'package:funapp/pages/sign_up_page.dart';
import 'package:funapp/pages/start_page.dart';

class MyRouteBuilder{
  static Route<dynamic> buidRoute(RouteSettings settings){
    final Map<String,dynamic> args=settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=>StartPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_)=>OnboardingScreen());
      case '/login':
        return MaterialPageRoute(builder: (_)=>LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_)=>SignUpPage());
      case '/home':
        return MaterialPageRoute(builder: (_)=>HomePage());
      case '/create':
        return MaterialPageRoute(builder: (_)=>NewPublicationPage());
      default: return errorRoute();
    }
  }

  static Route<dynamic> errorRoute(){
    return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('ERROR'),
            ),
          );
        }
    );
  }
}