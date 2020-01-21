import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebaseproject/pages/comments.dart';
import 'package:firebaseproject/pages/createPost.dart';
import 'package:firebaseproject/models/Post.dart';
import 'package:firebase_database/firebase_database.dart';

class LogOut extends StatelessWidget {
  final FirebaseUser user;
  LogOut(this.user);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts;
  bool isLoaded;

  @override
  void initState() {
    super.initState();
    posts = [];
    isLoaded = false;
  }

  loadData() {
    var postsRef = FirebaseDatabase.instance.reference().child("posts");
    postsRef.onChildAdded.listen((event) {
      Post post =  Post.fromJson(Map<String, dynamic>.from(event.snapshot.value));
      setState(() {
        isLoaded = true;
        posts.add(post);
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
        titleSpacing: -5.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset("assets/images/nav_icon.png", height: 14, width: 22),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF3D3D3D)),
        title: Text("New Talk", style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          )
        ),
        backgroundColor: Color(0xFFFBFBFB),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: GestureDetector(
               child: Container(
                 height: 37,
                 width: 50,
                 child: Image.asset("assets/images/photo-camera.png")
               ),
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Comments()));
               },
            )
          )
        ],
      ),
      drawer:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width-100,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 59, bottom: 26),
                  child: Image.asset("assets/images/author_image.png", fit: BoxFit.contain, width: 110, height: 110)
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 19),
                  child: Text("Fareed Ahmed Khan", style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600
                  ),
                    textAlign: TextAlign.center,
                  )
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text("50", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600
                          )
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text("POSTS", style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              )
                              )
                          )
                        ]
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("10", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600
                          )
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text("SHARES", style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              )
                              )
                          )
                        ]
                    ),
                    Column(
                        children: <Widget>[
                          Text("100", style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600
                          )
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text("VIEWS", style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              )
                              )
                          )
                        ]
                    )
                  ]
              ),
              Padding(
                  padding: EdgeInsets.only(top: 34, left: 31, right: 31),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("About Me", style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600
                        )
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Nunito',
                              ),
                              textAlign: TextAlign.justify,
                            )
                        )
                      ]
                  )
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                          padding: EdgeInsets.only(top: 13, right: 25, bottom: 13, left: 20),
                          color: Color(0xFF3D3D3D),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreatPost()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Post your Talk", style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                              )
                              ),
                              Icon(Icons.done, color: Colors.white, size: 23,)
                            ],
                          ),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                          color: Color(0xffFBFBFB),
                          padding: EdgeInsets.only(top: 13, right: 25, bottom: 13, left: 20),
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context,true);// It worked for me instead of above line
                            Navigator.pop(context,true);
                            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signIn()),);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Logout", style: TextStyle(
                                  color: Color(0xFF3D3D3D),
                                  fontFamily: 'Nunito',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                              )
                              ),
                              Image.asset("assets/images/logout.png", height: 18, width: 18)
                            ],
                          ),
                        )
                      ]
                  )
              )
            ]
          )
        )
      ),
      body: Container(
        margin: EdgeInsets.only(top:0, bottom: 0),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Divider(
                    height: 1,
                    color: Color(0xffDFDFDF)
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        child: Text("Fareed Ahmed Khan", style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600
                          )
                        )
                      )
                    ]
                  )
                ),
                Image(image: CachedNetworkImageProvider(
                    posts[index].image
                  ),
                  fit: BoxFit.cover, width: 418, height: 216
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("12,000 Views", style: TextStyle(
                              color: Colors.black, fontSize: 9, fontFamily: 'Montserrat', fontWeight: FontWeight.bold
                            )
                          )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          RichText(
                              text: new TextSpan(
                                  style: new TextStyle(fontSize: 11.0, fontFamily: 'Nunito', color: Colors.black),
                                  children: <TextSpan>[
                                    new TextSpan(text: 'Ishaq Hassan ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                    new TextSpan(text: 'Lorem ipsum dolor sit amet, consetetur',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal
                                        )
                                    )
                                  ]
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text("Fareed Ahmed Khan", style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold
                              ),
                                textAlign: TextAlign.left,
                              )
                          ),
                          Text(posts[index].postText,
                            style: TextStyle(
                              color: Color(0xff676767), fontSize: 9, fontFamily: 'Nunito',
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text("View all comments", style: TextStyle(
                                color: Color(0xffBBBBBB),
                                fontSize: 10,
                                fontFamily: 'Nuninto',
                                fontWeight: FontWeight.normal
                            )
                            ),
                          )
                        ]
                      )
                    ]
                  )
                ),
                SizedBox(height: 9),
                /*Divider(
                height: 1,
                color: Color(0xffDFDFDF)
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          child: Text("Fareed Ahmed Khan", style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600
                          )
                          )
                      )
                    ]
                )
            ),
            Image.asset("assets/images/post-image-2.png", fit: BoxFit.cover, width: 418, height: 216),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("12,000 Views", style: TextStyle(
                              color: Colors.black, fontSize: 9, fontFamily: 'Montserrat', fontWeight: FontWeight.bold
                          )
                          )
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                                text: new TextSpan(
                                    style: new TextStyle(fontSize: 11.0, fontFamily: 'Nunito', color: Colors.black),
                                    children: <TextSpan>[
                                      new TextSpan(text: 'Ishaq Hassan ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new TextSpan(text: 'Lorem ipsum dolor sit amet, consetetur',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal
                                          )
                                      )
                                    ]
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text("Fareed Ahmed Khan", style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold
                                ),
                                  textAlign: TextAlign.left,
                                )
                            ),
                            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat",
                                style: TextStyle(
                                  color: Color(0xff676767), fontSize: 9, fontFamily: 'Nunito',
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("View all comments", style: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10,
                                  fontFamily: 'Nuninto',
                                  fontWeight: FontWeight.normal
                              )
                              ),
                            )
                          ]
                      )
                    ]
                )
            ),
            SizedBox(height: 9),
            Divider(
                height: 1,
                color: Color(0xffDFDFDF)
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          child: Text("Fareed Ahmed Khan", style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600
                          )
                          )
                      )
                    ]
                )
            ),
            Image.asset("assets/images/post-image-3.png", fit: BoxFit.cover, width: 418, height: 216),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("12,000 Views", style: TextStyle(
                              color: Colors.black, fontSize: 9, fontFamily: 'Montserrat', fontWeight: FontWeight.bold
                          )
                          )
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                                text: new TextSpan(
                                    style: new TextStyle(fontSize: 11.0, fontFamily: 'Nunito', color: Colors.black),
                                    children: <TextSpan>[
                                      new TextSpan(text: 'Ishaq Hassan ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new TextSpan(text: 'Lorem ipsum dolor sit amet, consetetur',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.normal
                                          )
                                      )
                                    ]
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text("Fareed Ahmed Khan", style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold
                                ),
                                  textAlign: TextAlign.left,
                                )
                            ),
                            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat",
                                style: TextStyle(
                                  color: Color(0xff676767), fontSize: 9, fontFamily: 'Nunito',
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("View all comments", style: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10,
                                  fontFamily: 'Nuninto',
                                  fontWeight: FontWeight.normal
                              )
                              ),
                            )
                          ]
                      )
                    ]
                )
            ),*/
              ],
            );
          }
        )
      )
    );
  }
}
