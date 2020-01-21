import 'package:firebaseproject/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebaseproject/pages/signIn.dart';
import 'package:firebaseproject/pages/signUp.dart';

// ignore: must_be_immutable
class StyleText extends StatelessWidget{

  TapGestureRecognizer recognizer = TapGestureRecognizer();

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: new TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: new TextStyle(fontSize: 28.0, fontFamily: 'Nunito', color: Colors.black),
            children: <TextSpan>[
              new TextSpan(text: 'Welcome to', style: new TextStyle(fontWeight: FontWeight.normal)),
              new TextSpan(text: ' New Talk', style: new TextStyle(fontWeight: FontWeight.bold))
              ]
            )
          ),
          SizedBox(height: 4),
          Text("Please Login and Sign up to continue app", style: TextStyle(
            color: Color(0xff585858),
            fontSize: 11,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal
            ),
          )
        ]
      );
  }
}

class LoginText extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
                style: new TextStyle(fontSize: 15.0, fontFamily: 'Nunito', color: Color(0xFFB5B5B5)),
                children: <TextSpan>[
                  new TextSpan(text: 'Already have an account ? ', style: new TextStyle(fontWeight: FontWeight.normal)),
                  new TextSpan(text: 'Login now', style: new TextStyle(color: Color(0xFF3D3D3D), fontWeight: FontWeight.bold),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                      }
                  )
                ]
            )
          )
        ]
    );
  }
}

class DontSty extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(fontSize: 15.0, fontFamily: 'Nunito', color: Color(0xFFB5B5B5)),
              children: <TextSpan>[
                new TextSpan(text: 'Dont have an account ?  ', style: new TextStyle(fontWeight: FontWeight.normal)),
                new TextSpan(text: 'Register now', style: new TextStyle(color: Color(0xFF3D3D3D), fontWeight: FontWeight.bold),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  }
                )
              ]
            )
          )
        ]
    );
  }
}