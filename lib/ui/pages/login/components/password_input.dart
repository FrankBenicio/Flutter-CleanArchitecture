import '../login_presenter.dart';
import '../../../styles/styles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: 'Senha',
                errorText: snapshot.data?.isEmpty == true
                    ? null
                    : snapshot.data,
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