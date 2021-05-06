
import '../../../ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: R.strings.password,
                errorText: snapshot.hasData ? snapshot.data.description : null,
                icon: Icon(
                  Icons.lock,
                  color: primaryColorLight,
                )),
            obscureText: true,
            onChanged: presenter.validatePassword,
          );
        });
  }
}
