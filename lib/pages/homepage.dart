import 'package:firebasePractice/pages/authPage.dart';
import 'package:firebasePractice/pages/homePageA.dart';
import 'package:firebasePractice/utility/addSharedPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({this.user});

  User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddSharedPreferences addSharedPreferences;
  // String data;
  final firebasedb = FirebaseDatabase.instance.reference();
  bool isIt = true;

  void _writeData() {
    firebasedb.child("one").set({"id": "id1", "data": "Data"});
  }

  void _readData() {
    firebasedb.once().then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
    });
  }

  void _updateData() {
    firebasedb.child("one").update({"data": "changed data"});
  }

  void _deleteData() {
    firebasedb.child("one").remove();
  }

  Future<bool> _oneWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _oneWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("FirebasePractice"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.grey[200],
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: FlatButton(
                  onPressed: () {
                    isIt == true
                        ? Navigator.of(context).push(_createRoute(HomePageA()))
                        : Navigator.of(context)
                            .push(_createRoute2(HomePageA()));
                    if (isIt == true) {
                      setState(() {
                        isIt = false;
                      });
                    } else {
                      setState(() {
                        isIt = true;
                      });
                    }
                  },
                  child: Text(
                    "Page Route",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Write Data",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _writeData();
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Read Data",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _readData();
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Update Data",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _updateData();
                }),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Delete Data",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _deleteData();
                }),
            SizedBox(
              height: 100,
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  AddSharedPreferences addSharedPreferences =
                      AddSharedPreferences();
                  addSharedPreferences.setisLoggedIn(false);
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => AuthPage()));
                }),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute(Widget _page) {
  return PageRouteBuilder(
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) => _page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: Offset(1, 0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 400),
  );
}

Route _createRoute2(Widget _page) {
  return PageRouteBuilder(
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) => _page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: Offset(0, 1), end: Offset.zero)
          .chain(CurveTween(curve: Curves.ease));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 400),
  );
}
