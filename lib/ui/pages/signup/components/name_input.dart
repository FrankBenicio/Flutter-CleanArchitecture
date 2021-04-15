
import '../../../ui.dart';
import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: R.strings.name,
          icon: Icon(
            Icons.email,
            color: primaryColorLight,
          )),
      keyboardType: TextInputType.name,
    );
  }
}
