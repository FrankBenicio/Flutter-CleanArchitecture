import '../../../ui.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: null,
      child: Text(R.strings.addAccount.toUpperCase()),
    );
  }
}