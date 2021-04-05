import '../../factories.dart';
import '../../../../ui/pages/pages.dart';

import 'package:flutter/material.dart';

Widget makeLoginPage() {
  return LoginPage(makeLoginPresenter());
}
