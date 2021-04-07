import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:meta/meta.dart';

import 'splash_presenter.dart';


class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  SplashPage({@required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.loadCurrentAccount();
    return Builder(builder: (context) {
      presenter.navigateToStream.listen((page) {
        if (page?.isNotEmpty == true) {
          Get.offAllNamed(page);
        }
      });

      return Scaffold(
        appBar: AppBar(title: Text('4Dev')),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}