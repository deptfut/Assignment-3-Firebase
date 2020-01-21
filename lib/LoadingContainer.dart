import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  LoadingContainer({@required this.isLoading, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        isLoading ? overlay() : SizedBox()
      ]
    );
  }
  overlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: CircularProgressIndicator()
      )
    );
  }
}
