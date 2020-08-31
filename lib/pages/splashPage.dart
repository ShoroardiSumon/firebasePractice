import 'package:firebasePractice/pages/authPage.dart';
import 'package:firebasePractice/pages/homepage.dart';
import 'package:firebasePractice/utility/addSharedPreference.dart';
import 'package:firebasePractice/utility/contants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AddSharedPreferences addSharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
            color: ColorCode.PrimaryColor,
            child: Text(
              "Let's Go",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            onPressed: () {
              checkIsLoggedIn();
            }),
      ),
    );
  }

  void checkIsLoggedIn() async {
    AddSharedPreferences addSharedPreferences = new AddSharedPreferences();
    bool isLoggedIn = await addSharedPreferences.getisLoggedIn();

    if (isLoggedIn == true) {
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => AuthPage()));
    }
  }
}
