
import '../styles/styles.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [primaryColorLight, primaryColorDark]),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 4,
                color: blackColor)
          ],
          borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(80))),
      child: Image(
        image: AssetImage('lib/ui/assets/logo.png'),
      ),
    );
  }
}