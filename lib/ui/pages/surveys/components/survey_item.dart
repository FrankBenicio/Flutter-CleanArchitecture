import 'package:ForDev/ui/pages/pages.dart';
import 'package:ForDev/ui/styles/colors.dart';
import 'package:flutter/material.dart';

class SurveyItem extends StatelessWidget {
  final SurveyViewModel surveyViewModel;

  SurveyItem(this.surveyViewModel);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surveyViewModel.didAnswer ? secondaryColorDark : primaryColorDark,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2,
                color: blackColor)
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              surveyViewModel.date,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              surveyViewModel.question,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
