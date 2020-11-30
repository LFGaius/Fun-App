
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:pakle/afri_spinner.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailctrl=new TextEditingController();
  TextEditingController passwordctrl=new TextEditingController();
  Map<String,String> errormsg={'global':'','email':'','username':'','password':''};
  bool actionpending=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: ConfigDatas.boxDecorationWithBackgroundGradient,
          child: ListView(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10),
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/logo.png",
                  height: MediaQuery.of(context).size.height*0.15,
                ),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.05,
                child:Center(
                  child: Text(
                    errormsg['global'].toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize:12,
                    ),
                  ),
                ),
              ),
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConfigDatas.appWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.75,
                    child: CustomTextField(
                      controller:emailctrl,
                      label:'Email',
                      hintText: 'Enter your email',
                      errorMessage: errormsg['email'].toUpperCase(),
                      obscureText: false,
                    ),
                  ),
                  SizedBox(height:MediaQuery.of(context).size.height*0.03),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.75,
                    child: CustomTextField(
                      controller:passwordctrl,
                      label:'Password',
                      hintText: 'Enter your password',
                      errorMessage: errormsg['password'].toUpperCase(),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width*0.12),
                  SizedBox(
                    width:MediaQuery.of(context).size.width*0.55,
                    child: RaisedButton(
                      color: ConfigDatas.loginFlowButtonColor,
                      padding: EdgeInsets.all(20),
                      elevation: 5,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: ConfigDatas.appWhiteColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                      onPressed: loginOperation,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width*0.005),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: ConfigDatas.appWhiteColor,
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/signup',
                            );
                          },
                        ),
                        Text(
                          '|',
                          style: TextStyle(
                            color: ConfigDatas.appWhiteColor,
                            fontWeight:FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            'Forgot password',
                            style: TextStyle(
                              color: ConfigDatas.appWhiteColor,
                              fontWeight:FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () {
                            // Navigator.of(context).pushNamed(
                            //     '/recoveryinfopage'
                            // );
                          },
                        )
                      ]
                  )
                ],
              )
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  loginOperation() async{

    errormsg['global']='';
    errormsg['email']='';
    errormsg['password']='';
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailctrl.text,
          password: passwordctrl.text
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      switch(e.code){
        case 'user-not-found':setErrorMessages({
          'globalError':'No user found for that email.'
        });
        break;
        case 'wrong-password':setErrorMessages({
          'password':'Wrong password provided for that user.'
        });
        break;
        case 'invalid-email':setErrorMessages({
          'email':'The email address is badly formatted.'
        });
        break;
        default:setErrorMessages({
          'globalError':e.message
        });
      }
    }
    // Navigator.of(context).pushNamed(
    //   '/home',
    // );
    // try{
    //   setActionPending(true);
    //   String userData=jsonEncode(<String, String>{
    //     'email':emailctrl.text,
    //     'password':passwordctrl.text
    //   });
    //
    //   final response = await http.post(
    //     'http://10.0.2.2:3000/login',
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: userData,
    //   );
    //   setActionPending(false);
    //   Map<String,dynamic> parsedbody=json.decode(response.body);
    //   if(response.statusCode!=200)
    //     setErrorMessages(parsedbody);
    //   else
    //     Navigator.of(context).pushNamed(
    //         '/verificationcode',
    //         arguments:{
    //           'optype':'login',
    //           'userData':parsedbody
    //         }
    //     );
    //
    // }catch(e){
    //   setState(() {
    //     if(e.runtimeType.toString()=='SocketException')
    //       errormsg['global']='Connection Problem!';
    //     else
    //       errormsg['global']='Problem Encounted!';
    //     actionpending=false;
    //   });
    // }
  }

  setActionPending(value){
    setState(() {
      actionpending=value;
    });
  }

  setErrorMessages(messageMap){
    setState(() {
      errormsg['global']=messageMap['globalError']!=null?messageMap['globalError']:'';
      errormsg['email']=messageMap['email']!=null?messageMap['email']:'';
      errormsg['password']=messageMap['password']!=null?messageMap['password']:'';
    });
  }
}
