import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'Home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/models/Comment.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

  class _CommentsState extends State<Comments> {

  List<Comment> comments;
  TextEditingController commentTextCtrl;
  bool isLoaded;

  @override
  void initState() {
    super.initState();
    commentTextCtrl = TextEditingController();
    comments = [];
    isLoaded = false;
  }

  sendComment(){
    String commentsText = commentTextCtrl.text;
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("comments");
    var key = reference.push().key;
    DatabaseReference nComment = reference.child(key);
    nComment.set(Comment(commentsText).toJson());
    //Navigator.of(context).pop(Home());
    commentTextCtrl.clear();
  }

  loadData() {
    var commentsRef = FirebaseDatabase.instance.reference().child("comments");
    commentsRef.onChildAdded.listen((event){
      Comment comment = Comment.fromJson(Map<String, dynamic>.from(event.snapshot.value));
      setState(() {
        isLoaded = true;
        comments.add(comment);
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    if (!isLoaded) {
      loadData();
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -7.0,
        backgroundColor: Color(0xFFFBFBFB),
        iconTheme: IconThemeData(color: Color(0xFF3D3D3D)),
        title: Text("Comments", style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          )
        )
      ),
      body: Container(
        margin: EdgeInsets.only(top: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 13.5),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile-1.jpg',
                      fit: BoxFit.cover,
                      matchTextDirection: true,
                      height: 35,
                      width: 35,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(fontSize: 12.0, fontFamily: 'Montserrat', color: Colors.black),
                                children: <TextSpan>[
                                  new TextSpan(text: 'Fareed Ahmed Khan  ', style: new TextStyle(fontWeight: FontWeight.w600)),
                                  new TextSpan(text: 'Lorem ipsum dolor sit amet,',
                                      style: new TextStyle(
                                          color: Color(0xFF3D3D3D),
                                          fontSize: 11,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.normal)
                                  )
                                ]
                            )
                        )
                      ]
                    )
                  )
                ]
              )
            ),
            Divider(
                height: 1,
                color: Colors.black26
            ),
            SizedBox(height: 15),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
                        child: Wrap(
                          children: <Widget>[
                            RichText(
                                  //overflow: TextOverflow.ellipsis,
                                  text: new TextSpan(
                                    style: new TextStyle(fontSize: 11.0, fontFamily: 'Nunito', color: Colors.black),
                                    children: <TextSpan>[
                                      new TextSpan(text: 'Ishaq Hassan  ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new TextSpan(text: comments[index].commentsText,
                                          style: new TextStyle(color: Color(0xFF3D3D3D), fontSize: 11, fontWeight: FontWeight.normal))
                                    ]
                                  )
                                )
                          ],
                        )
                      )
                    ],
                  );
                }
              )

              /*ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(fontSize: 11.0, fontFamily: 'Nunito', color: Colors.black),
                            children: <TextSpan>[
                              new TextSpan(text: 'Ishaq Hassan  ', style: new TextStyle(fontWeight: FontWeight.bold)),
                              new TextSpan(text: 'Lorem ipsum dol sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et',
                                  style: new TextStyle(color: Color(0xFF3D3D3D), fontSize: 11, fontWeight: FontWeight.normal))
                            ]
                          )
                        )
                      ]
                    )
                  )
                ]
              )*/
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    color: Color(0xFFF6F6F6),
                    padding: EdgeInsets.fromLTRB(11, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 27,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile-1.jpg',
                                fit: BoxFit.cover,
                                matchTextDirection: true,
                                height: 27,
                                width: 27,
                              )
                            )
                          )
                        ),
                        Flexible(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: TextFormField(
                              controller: commentTextCtrl,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write something about post',
                              ),
                              style: TextStyle(
                                color: Colors.black, fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.w600
                              ),
                            )
                          )
                        ),
                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            child: SizedBox(
                                height: 46,
                                width: 46,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 15, 11, 15),
                                  child: Image.asset("assets/images/send.png", height: 16, width: 16),
                                )
                            ),
                            onTap: sendComment,
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}