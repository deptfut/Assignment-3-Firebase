import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebaseproject/pages/Home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseproject/models/Post.dart';
import 'package:image_picker/image_picker.dart';

typedef OnFileDone(StorageReference storageReference);

class CreatPost extends StatefulWidget {
  @override
  _CreatPostState createState() => _CreatPostState();
}

class _CreatPostState extends State<CreatPost> {
  TextEditingController postTextCtrl;

  @override
  void initState() {
    super.initState();
    postTextCtrl = TextEditingController();
  }

  File image;

  uploadImage(String key, OnFileDone onDone) {
    FirebaseStorage.instance
        .ref()
        .child(key + ".jpg")
        .putFile(image)
        .events
        .listen((event) {
      if (event.type == StorageTaskEventType.success) {
        onDone(event.snapshot.ref);
      } else if (event.type == StorageTaskEventType.failure) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Fail to upload image!"),
        ));
      }
    });
  }

  postTalk() {
    String postText = postTextCtrl.text;

    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("posts");
    var key = reference.push().key;
    DatabaseReference nsPost = reference.child(key);
    nsPost.set(Post(postText).toJson());
    uploadImage(key, (fileRef) {
      fileRef.getDownloadURL().then((uri) {
        nsPost.child("image").set(uri.toString());
      });
    });
    Navigator.of(context).pop(Home());
  }

  getImage() async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFFBFBFB),
            iconTheme: IconThemeData(color: Color(0xFF3D3D3D)),
            titleSpacing: -7.0,
            title: Text("Create Post",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ))),
        body: Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              Expanded(
                  flex: 2,
                  child: ListView(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: postTextCtrl,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                top: 0, right: 16, left: 16),
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 25,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.normal),
                            hintText: "What's on your mind ?",
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.normal),
                          maxLines: 6,
                        )),
                    Divider(height: 1, color: Colors.black26),
                    Container(
                        color: Color(0XFFFBFBFB),
                        padding:
                            EdgeInsets.symmetric(horizontal: 19, vertical: 15),
                        child: InkWell(
                            child: Row(children: <Widget>[
                              Image.asset(
                                  "assets/images/photo-of-a-landscape.png",
                                  height: 20,
                                  width: 25),
                              Padding(
                                  padding: EdgeInsets.only(left: 11.06),
                                  child: Text("Add Picture",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Nunito')))
                            ]),
                            onTap: () {
                              getImage();
                            })),
                    Container(
                      child: image != null
                          ? Image.file(
                              image,
                              fit: BoxFit.cover,
                              height: 216,
                              width: 418,
                            )
                          : Container(),
                    )
                  ])),
              Padding(
                  padding:
                      EdgeInsets.only(top: 0, right: 42, bottom: 35, left: 42),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                            padding: EdgeInsets.only(
                                top: 13, right: 24, bottom: 13, left: 23),
                            color: Color(0xFF3D3D3D),
                            elevation: 0.0,
                            onPressed: postTalk,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Post your Talk",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600)),
                                  Icon(Icons.done,
                                      color: Colors.white, size: 27)
                                ]))
                      ])),
              /*Expanded(
              flex: 1,
              child:
            )*/
            ])));
  }
}
