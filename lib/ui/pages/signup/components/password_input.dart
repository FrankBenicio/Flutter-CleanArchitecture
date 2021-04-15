
import '../../../ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: R.strings.password,
          icon: Icon(
            Icons.lock,
            color: primaryColorLight,
          )),
      obscureText: true,
    );
  }
}
