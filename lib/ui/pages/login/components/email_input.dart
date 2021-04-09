import 'package:ForDev/utils/i18n/i18n.dart';

import '../../../ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
                labelText: R.strings.email,
                errorText: snapshot.hasData ? snapshot.data.description : null,
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
