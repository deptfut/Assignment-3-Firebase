import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/LoadingContainer.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/UI/SoicalButtons.dart';
import 'package:firebaseproject/UI/Seprator.dart';
import 'package:firebaseproject/UI/TextSty.dart';
import 'package:firebaseproject/pages/Home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameFieldCtrl;
  TextEditingController emailFieldCtrl;
  TextEditingController passwordFieldCtrl;
  TextEditingController cpasswordFieldCtrl;

  var formKey = GlobalKey<FormState>();
  bool isLoading;
  String error;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    error = "";
    nameFieldCtrl = TextEditingController();
    emailFieldCtrl = TextEditingController();
    passwordFieldCtrl = TextEditingController();
    cpasswordFieldCtrl = TextEditingController();
    checkUser();
  }

  checkUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  registerNow() async{
    try{
      setState(() {
        isLoading = true;
      });
      var auth = FirebaseAuth.instance;
      var response = await auth.createUserWithEmailAndPassword(
          email: emailFieldCtrl.text, password: passwordFieldCtrl.text);

      //Get the created user
      FirebaseUser u = response.user;

      //Build profile update request
      var infoUpdate = UserUpdateInfo();
      infoUpdate.displayName = nameFieldCtrl.text;

      //Update profile now!
      await u.updateProfile(infoUpdate);

      FirebaseUser realtimeUser = await auth.currentUser();
      print(realtimeUser.displayName);
      checkUser();
    } catch (e) {
      print(e);
      error = "There was a problem while creating user account!";
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return LoadingContainer(
      isLoading: isLoading,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 35, left: 30, right: 30, bottom: 20),
          child: ListView(
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
                      child: Text("or",
                          style: TextStyle(
                              color: Color(0xffB5B5B5),
                              fontSize: 23,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold))),
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
                        controller: nameFieldCtrl,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            color: Color(0xff3D3D3D)
                        ),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Color(0xFF3D3D3D),
                                fontSize: 14
                            ),
                            labelText: 'Full Name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Color(0xFFB5B5B5),
                                width: 1.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 12.5
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                                color: Color(0xFFB5B5B5), fontSize: 14
                            ),
                            hintText: 'Please enter your name',
                            suffixIcon: Image.asset("assets/images/user_icon.png",
                                width: 27.0, height: 27.0)
                        ),
                        keyboardType: TextInputType.text,
                        validator: (valueName) {
                          Pattern pattern =
                              r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]';
                          RegExp regexs = new RegExp(pattern);
                          if (!regexs.hasMatch(valueName)) {
                            return 'Please enter your valid name';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 27),
                    TextFormField(
                        controller: emailFieldCtrl,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            color: Color(0xff3D3D3D)
                        ),
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
                                horizontal: 14.0, vertical: 12.5
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                                color: Color(0xFFB5B5B5), fontSize: 14
                            ),
                            hintText: 'Please enter your email',
                            suffixIcon: Image.asset("assets/images/envelope.png",
                                width: 25.0, height: 20.0)
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (valueEmail) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(valueEmail)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 27),
                    TextFormField(
                        controller: passwordFieldCtrl,
                        obscureText: true,
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.normal,
                            color: Color(0xff3D3D3D)),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Color(0xFF3D3D3D), fontSize: 14),
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide(
                                color: Color(0xFFB5B5B5),
                                width: 1.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 12.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            hintStyle: TextStyle(
                                color: Color(0xFF3D3D3D), fontSize: 14),
                            hintText:
                            'Please enter your password',
                            suffixIcon: Image.asset(
                                "assets/images/password.png",
                                width: 21,
                                height: 24)),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.length < 6) {
                            return ("Password must be at least 6 characters");
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 27),
                    TextFormField(
                      controller: cpasswordFieldCtrl,
                      obscureText: true,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.normal,
                          color: Color(0xff3D3D3D)),
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color(0xFF3D3D3D), fontSize: 14),
                          labelText: 'Confirm Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
                              color: Color(0xFFB5B5B5),
                              width: 1.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 12.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          hintStyle: TextStyle(
                              color: Color(0xFFB5B5B5), fontSize: 14),
                          hintText: 'Please enter your confirm password',
                          suffixIcon: Image.asset(
                              "assets/images/password.png",
                              width: 21,
                              height: 24)),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (passwordFieldCtrl.text != value) {
                          return ("Password did not match");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 29),
                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                      padding: EdgeInsets.symmetric(vertical: 11),
                      color: Color(0xFF3D3D3D),
                      elevation: 0.0,
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          registerNow();
                        }
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Nunito',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 23),
                    LoginText(),
                  ]
                )
              )
            ]
          )
        )
      ),
    );
  }
}

