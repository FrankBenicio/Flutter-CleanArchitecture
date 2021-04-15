
import '../../../ui.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: R.strings.email,
          icon: Icon(
            Icons.email,
            color: primaryColorLight,
          )),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
