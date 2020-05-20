import 'package:flutter/material.dart';
import 'package:flutterphoneauth/Screens/LoginScreen.dart';
import 'package:flutterphoneauth/Utils/Firebase.dart';

class Homepage extends StatefulWidget {
  String contact;

  Homepage(this.contact);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Firebase firebase = Firebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact),
        actions: [
          FlatButton(
            child: Text("Logout"),
            onPressed: () => firebase.logout().then((value) =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()))),
          )
        ],
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
