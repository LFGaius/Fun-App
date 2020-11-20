import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int numpages=2;
  final PageController pagecontroller=PageController(initialPage: 0);
  int currentpage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          decoration:ConfigDatas.boxDecorationWithBackgroundGradient,
          child: Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
              child:Column(
                  children:[
                    Container(
                      height:MediaQuery.of(context).size.height*0.7,
                      child:PageView(
                          physics: ClampingScrollPhysics(),
                          controller:pagecontroller,
                          onPageChanged: (int page) {
                            setState(() {
                              currentpage=page;
                            });
                          },
                          children:[
                            OnboardingSlide(
                              imagepath: 'assets/onboardillust1.png',
                              message: 'Share fun with the world',
                            ),
                            OnboardingSlide(
                              imagepath: 'assets/onboardillust2.png',
                              message: 'Only with text isd the rule',
                            )
                          ]
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DotsIndicator(
                              dotsCount: numpages,
                              position: currentpage.toDouble(),
                              decorator:DotsDecorator(
                                  color: Color.fromRGBO(249, 249, 249, 0.3),
                                  activeColor: ConfigDatas.appWhiteColor,
                                  size: Size.fromRadius(17),
                                  activeSize:Size.fromRadius(17)
                              )
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          child: Text(
                            (currentpage==numpages-1)?'Get Started':'Skip',
                            style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 28,
                              color: ConfigDatas.appWhiteColor
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(
                                '/login'
                            );
                          },
                        )
                      ],
                    ),
                  ]
              )
          ),
        )
    );
  }

}

