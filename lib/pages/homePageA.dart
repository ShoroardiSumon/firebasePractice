import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePageA extends StatefulWidget {
  @override
  _HomePageAState createState() => _HomePageAState();
}

class _HomePageAState extends State<HomePageA> {
  String name, desc;
  StreamSubscription<DocumentSnapshot> subscription;

  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("myData/dummy");

  void _addData() {
    Map<String, String> data = <String, String>{
      "name": "Shoroardi Sumon",
      "desc": "Flutter Developer"
    };
    documentReference.set(data).whenComplete(() {
      print("Document Added");
    }).catchError((e) => print(e));
  }

  void _getData() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          name = datasnapshot.data()['name'];
          desc = datasnapshot.data()['desc'];
        });
        print("Get Document");
      } else {
        name = null;
        desc = null;
      }
    });
  }

  void _updateData() {
    Map<String, String> data = <String, String>{
      "name": "Shoroardi Sumon Updated",
      "desc": "Flutter Developer Updated"
    };
    documentReference.update(data).whenComplete(() {
      print("Document Updated");
    }).catchError((e) => print(e));
  }

  void _deleteData() {
    documentReference.delete().whenComplete(() {
      print("Deleted Successfully");
      setState(() {});
    }).catchError((e) => print(e));
  }

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          name = datasnapshot.data()['name'];
          desc = datasnapshot.data()['desc'];
        });
      } else {
        name = null;
        desc = null;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePageA"),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Add Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _addData();
                  }),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Get Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _getData();
                  }),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Update Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _updateData();
                  }),
              SizedBox(
                height: 20,
              ),
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
                height: 20,
              ),
              name == null
                  ? Container()
                  : Column(
                      children: <Widget>[
                        Text(
                          name,
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          desc,
                          style: new TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
