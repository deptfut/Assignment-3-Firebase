import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> with TickerProviderStateMixin {


  String image1 = "http://via.placeholder.com/350x150";
  String image2 = "http://via.placeholder.com/200x150";
  String image3 = "http://via.placeholder.com/400x150";
  String currentMainImage = "http://via.placeholder.com/350x150" ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: new Text("table demo"),
            ),
            body: new Container(
                child: new Column(
                  children: <Widget>[
                    Container(
                        height:150.0,
                        child: new Image.network(currentMainImage,fit: BoxFit.fill,)
                    ),
                    new Row(
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                                onTap : (){
                                  setState(() {
                                    currentMainImage = image1;
                                  });
                                },
                                child: new Image.network(image1)
                            )
                        ),
                        Expanded(
                            child: InkWell(
                                onTap : (){
                                  setState(() {
                                    currentMainImage = image2;
                                  });
                                },
                                child: new Image.network(image2)
                            )
                        ),
                        Expanded(
                            child: InkWell(
                                onTap : (){
                                  setState(() {
                                    currentMainImage = image3;
                                  });
                                },
                                child: new Image.network(image3)
                            )
                        ),
                      ],
                    )
                  ],

                )
            )
        )
    );
  }
}