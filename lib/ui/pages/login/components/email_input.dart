import '../login_presenter.dart';

import '../../../styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EmailInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<String>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: snapshot.data?.isEmpty == true
                    ? null
                    : snapshot.data,
                icon: Icon(
                  Icons.email,
                  color: primaryColorLight,
                )),
            keyboardType: TextInputType.emailAddress,
            onChanged: presenter.validateEmail,
          );
        });
  }
}