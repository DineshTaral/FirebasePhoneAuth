import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterphoneauth/Utils/Firebase.dart';
import 'package:flutterphoneauth/Utils/Utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingController = TextEditingController();
  Firebase firebase = Firebase();

  @override
  Widget build(BuildContext context) {
    Utils.deviceHeight = MediaQuery.of(context).size.height;
    Utils.deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Phone Auth"),
      ),
      body: Container(
        width: Utils.deviceWidth,
        height: Utils.deviceHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Utils.deviceWidth / 1.1,
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey)),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "Enter pnone number",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20.0)),
              keyboardType: TextInputType.number,),
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }

  signIn() {
    if (textEditingController.text.isEmpty) {
      Utils.showToast("Please enter phone number");
    }
    firebase.verifyPhone(context, textEditingController.text).then((value) {
      print("done");
    }).catchError((onError) => print(onError));
  }
}
