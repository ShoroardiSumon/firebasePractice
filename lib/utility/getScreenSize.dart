import 'package:flutter/cupertino.dart';

double screenHeight;
double screenWidth;
DateTime dateTimeNow;
double marginHorizontal;
double marginVertical;

void getScreenSize(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
  marginHorizontal = screenWidth * 0.01;
  marginVertical = screenHeight * 0.03;
  dateTimeNow = new DateTime.now();
}
