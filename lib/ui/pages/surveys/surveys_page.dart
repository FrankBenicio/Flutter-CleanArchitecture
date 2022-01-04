import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../ui.dart';
import 'components/components.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  SurveysPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    presenter.loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
      ),
      body: StreamBuilder<List<SurveyViewModel>>(
          stream: presenter.loadSurveysStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.error,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: presenter.loadData,
                      child: Text(R.strings.recharge),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    aspectRatio: 1,
                  ),
                  items: snapshot.data
                      .map((viewModel) => SurveyItem(viewModel))
                      .toList(),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
