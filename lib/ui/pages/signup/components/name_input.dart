
import '../../../ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.nameErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: R.strings.name,
                errorText: snapshot.hasData ? snapshot.data.description : null,
                icon: Icon(
                  Icons.person,
                  color: primaryColorLight,
                )),
            keyboardType: TextInputType.text,
            onChanged: presenter.validateName,
          );
        });
  }
}
