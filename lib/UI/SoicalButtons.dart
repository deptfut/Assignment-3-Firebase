import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 55, right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 133,
            padding: EdgeInsets.only(top: 10,  bottom: 10, right: 35, left: 35),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xffB5B5B5),
                    width: 1.0
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0) //         <--- border radius here
                )
            ),
            child: Image.asset("assets/images/google.png", fit: BoxFit.contain, width: 83, height: 28),
          ),
          Container(
            width: 133,
            padding: EdgeInsets.only(top: 12, bottom: 13, right: 20, left: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xffB5B5B5),
                    width: 1.0
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0) //         <--- border radius here
                )
            ),
            child: Image.asset("assets/images/facebook.png", fit: BoxFit.contain, width: 114, height: 24),
          )
        ],
      ),
    );
  }
}