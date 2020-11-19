
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

  Map<String,String> errormsg={'global':'','email':'','username':'','password':''};
  TextEditingController usernamectrl=new TextEditingController();
  TextEditingController emailctrl=new TextEditingController();
  TextEditingController passwordctrl=new TextEditingController();
  TextEditingController rpasswordctrl=new TextEditingController();
  bool actionpending=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: ConfigDatas.boxDecorationWithBackgroundGradient,
          child: ListView(
            padding: EdgeInsets.only(top:0),
            children: <Widget>[
              Container(
                child: Image.asset(
                  "assets/toplogin.png",
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Row(
                  children:<Widget>[
                    IconButton(
                      icon:new Icon(
                        Icons.keyboard_arrow_left,
                        color: Color.fromRGBO(27, 34, 50, 1),
                        size: MediaQuery.of(context).size.width*0.1,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/login',
                        );
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: Text(
                        errormsg['global'].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize:12,
                        ),
                      ),
                    )
                  ]
              ),
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(27, 34, 50, 0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                    children: <Widget>[
                      CustomTextField(
                          controller:usernamectrl,
                          hintText: 'Enter your username',
                          errorMessage: errormsg['username'].toUpperCase(),
                          obscureText: false,
                          icon:Icon(Icons.person)
                      ),
                      CustomTextField(
                          controller:emailctrl,
                          hintText: 'Enter your email',
                          errorMessage: errormsg['email'].toUpperCase(),
                          obscureText: false,
                          icon:Icon(Icons.email)
                      ),
                      CustomTextField(
                          controller:passwordctrl,
                          hintText: 'Enter your password',
                          errorMessage: errormsg['password'].toUpperCase(),
                          obscureText: true,
                          icon:Icon(Icons.vpn_key)
                      ),
                      CustomTextField(
                          controller:rpasswordctrl,
                          hintText: 'Reapeat your password',
                          errorMessage: '',
                          obscureText: true,
                          icon:Icon(Icons.vpn_key)
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.95,
                        child: RaisedButton(
                          color: Color.fromRGBO(27, 34, 50, 1),
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Color.fromRGBO(250, 218, 0, 1),
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: signupOperation,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      )
                    ]
                ),
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
    try{
      setActionPending(true);
      String userData=jsonEncode(<String, String>{
        'username':usernamectrl.text,
        'email':emailctrl.text,
        'password':passwordctrl.text,
        'rpassword':rpasswordctrl.text
      });

      final response = await http.post(
        'http://10.0.2.2:3000/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: userData,
      );
      setActionPending(false);
      if(response.statusCode!=200){
        Map<String,dynamic> parsedbody=json.decode(response.body);
        setErrorMessages(parsedbody);
      }else
        Navigator.of(context).pushNamed(
            '/verificationcode',
            arguments:{
              'optype':'signup',
              'userData':{
                'username':usernamectrl.text,
                'email':emailctrl.text,
                'password':passwordctrl.text,
                'rpassword':rpasswordctrl.text
              }
            }
        );

    }catch(e){
      setState(() {
        if(e.runtimeType.toString()=='SocketException')
          errormsg['global']='Connection Problem!';
        else
          errormsg['global']='Problem Encounted!';
        actionpending=false;
      });
    }
  }

  setActionPending(value){
    setState(() {
      actionpending=value;
    });
  }

  setErrorMessages(parsedbody){
    setState(() {
      errormsg['global']=parsedbody['globalError']!=null?parsedbody['globalError']['msg']:'';
      errormsg['email']=parsedbody['email']!=null?parsedbody['email']['msg']:'';
      errormsg['username']=parsedbody['username']!=null?parsedbody['username']['msg']:'';
      errormsg['password']=parsedbody['password']!=null?parsedbody['password']['msg']:'';
    });
  }

}