
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funapp/configs/config_datas.dart';
import 'package:funapp/widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  Map<String,String> errormsg={'global':'','email':'','password':''};
  TextEditingController emailctrl=new TextEditingController();
  TextEditingController passwordctrl=new TextEditingController();
  TextEditingController rpasswordctrl=new TextEditingController();
  bool actionpending=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: ConfigDatas.boxDecorationWithBackgroundGradient,
          child: ListView(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05),
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/logo.png",
                  height: MediaQuery.of(context).size.height*0.15,
                ),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height*0.04,
                child:Center(
                  child: Text(
                    errormsg['global'].toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize:15,
                    ),
                  ),
                ),
              ),
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConfigDatas.appWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Column(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: CustomTextField(
                          label:'Email',
                          controller:emailctrl,
                          hintText: 'Enter your email',
                          errorMessage: errormsg['email'].toUpperCase(),
                          obscureText: false,
                          icon:Icon(Icons.email)
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: CustomTextField(
                          label:'Password',
                          controller:passwordctrl,
                          hintText: 'Enter your password',
                          errorMessage: errormsg['password'].toUpperCase(),
                          obscureText: true,
                          icon:Icon(Icons.vpn_key)
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: CustomTextField(
                          label:'Verify Password',
                          controller:rpasswordctrl,
                          hintText: 'Reapeat your password',
                          errorMessage: '',
                          obscureText: true,
                          icon:Icon(Icons.vpn_key)
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    SizedBox(
                      width:MediaQuery.of(context).size.width*0.55,
                      child: RaisedButton(
                        color: ConfigDatas.loginFlowButtonColor,
                        padding: EdgeInsets.all(20),
                        elevation: 5,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: ConfigDatas.appWhiteColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900
                          ),
                        ),
                        onPressed: signupOperation,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: ConfigDatas.appWhiteColor,
                                fontWeight:FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/login',
                              );
                            },
                          ),
                        ]
                    )
                  ]
              )
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  signupOperation() async{
    errormsg['global']='';
    errormsg['email']='';
    errormsg['username']='';
    errormsg['password']='';

    if(passwordctrl.text!=rpasswordctrl.text)
      setErrorMessages({
        'globalError':"Passwords don't match."
      });
    else
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailctrl.text,
            password: passwordctrl.text
        );
      } on FirebaseAuthException catch (e) {
      print(e);
        switch(e.code) {
          case 'weak-password':
            setErrorMessages({
              'password': "The password provided is too weak."
            });
            break;
          case 'email-already-in-use':
            setErrorMessages({
              'email': "The account already exists for that email."
            });
            break;
          case 'invalid-email':
            setErrorMessages({
              'email': e.message
            });
            break;
          default:
            setErrorMessages({
              'globalError': e.message
            });
        }
      } catch (e) {
        print(e);
      }
    // Navigator.of(context).pushNamed(
    //   '/home',
    // );
    // try{
    //   setActionPending(true);
    //   String userData=jsonEncode(<String, String>{
    //     'username':usernamectrl.text,
    //     'email':emailctrl.text,
    //     'password':passwordctrl.text,
    //     'rpassword':rpasswordctrl.text
    //   });
    //
    //   final response = await http.post(
    //     'http://10.0.2.2:3000/signup',
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: userData,
    //   );
    //   setActionPending(false);
    //   if(response.statusCode!=200){
    //     Map<String,dynamic> parsedbody=json.decode(response.body);
    //     setErrorMessages(parsedbody);
    //   }else
    //     Navigator.of(context).pushNamed(
    //         '/verificationcode',
    //         arguments:{
    //           'optype':'signup',
    //           'userData':{
    //             'username':usernamectrl.text,
    //             'email':emailctrl.text,
    //             'password':passwordctrl.text,
    //             'rpassword':rpasswordctrl.text
    //           }
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