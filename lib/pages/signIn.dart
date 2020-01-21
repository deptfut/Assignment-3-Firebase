import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/LoadingContainer.dart';
import 'package:firebaseproject/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/UI/TextSty.dart';
import 'package:firebaseproject/UI/SoicalButtons.dart';
import 'package:firebaseproject/UI/Seprator.dart';
import 'package:firebaseproject/pages/signUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailFieldCtrl;
  TextEditingController passwordFieldCtrl;

  var formKey = GlobalKey<FormState>();
  bool isLoading;
  String error;

  @override
  void initState() {
    super.initState();
    emailFieldCtrl = TextEditingController();
    passwordFieldCtrl = TextEditingController();

    isLoading = false;
    error = "";
    checkUser();
  }

  checkUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  loginNow() async{
    try{
      setState(() {
        isLoading = true;
      });
      var auth = FirebaseAuth.instance;
      var response = await auth.signInWithEmailAndPassword(
          email: emailFieldCtrl.text, password: passwordFieldCtrl.text
      );
      checkUser();
    } catch (e) {
      print(e);
      error = "There was a problem while login in!";
    } finally{
      setState(() {
        isLoading = false;
      });
    }
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      isLoading: isLoading,
      child: Scaffold(
          body:  Container(
              margin: EdgeInsets.only(top: 42, left: 30, right: 30, bottom: 20),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    StyleText(),
                    SocialButtons(),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Separator(),
                        Padding(
                            padding: EdgeInsets.only(left: 14.5, right: 14.5),
                            child: Text("or", style: TextStyle(
                                color: Color(0xffB5B5B5),
                                fontSize: 21,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold
                            )
                            )
                        ) ,
                        Separator(),
                      ],
                    ),
                    SizedBox(height: 20),
                    error.isNotEmpty ? Text(error, style: TextStyle(fontSize: 13, fontFamily: 'Nunito', fontWeight: FontWeight.bold),textAlign: TextAlign.center,) : SizedBox(),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                              controller: emailFieldCtrl,
                              style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.normal, color: Color(0xff3D3D3D)),
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFF3D3D3D),
                                      fontSize: 14
                                  ),
                                  labelText: 'Email',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFB5B5B5),
                                      width: 1.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14.0,
                                      vertical: 12.5
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Color(0xFFB5B5B5),
                                      fontSize: 14
                                  ),
                                  hintText: 'Please enter your email',
                                  suffixIcon: Image.asset("assets/images/envelope.png", width: 25.0, height: 20.0)
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Enter Valid Email';
                                else
                                  return null;
                              }
                          ),
                          SizedBox(height: 27),
                          TextFormField(
                              controller: passwordFieldCtrl,
                              obscureText: true,
                              style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.normal, color: Color(0xff3D3D3D)),
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                      color: Color(0xFF3D3D3D),
                                      fontSize: 14
                                  ),
                                  labelText: 'Password',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Color(0xFFB5B5B5),
                                      width: 1.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14.0,
                                      vertical: 12.5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Color(0xFFB5B5B5),
                                      fontSize: 14
                                  ),
                                  hintText: 'Please enter your confirm password',
                                  suffixIcon: Image.asset("assets/images/password.png", width: 21, height: 24)
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.length < 6) {
                                  return ("Password must be at least 6 characters");
                                }
                                return null;
                              }
                          ),
                          SizedBox(height: 17),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                child: Text("Forgot password ?", style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 15,
                                ),
                                  textAlign: TextAlign.right,
                                ),
                                onTap: (){
                                  Navigator.of(context).pop(SignUp());
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 17),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            padding: EdgeInsets.symmetric(vertical: 11),
                            color: Color(0xFF3D3D3D),
                            elevation: 0.0,
                            onPressed: (){
                              if(formKey.currentState.validate()) {
                                loginNow();
                              }
                            },
                            child: Text("Login Now", style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                            ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 23),
                    DontSty(),
                  ]
              )
          )
      )
    );
  }
}

