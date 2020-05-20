import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterphoneauth/Screens/Homepage.dart';

class Firebase {
  String smsCode;
  String verificationId;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  //register with phone
  Future<void> verifyPhone(BuildContext context, String phone) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      print('codeAutoRetrievalTimeout $verId');
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      print('codeSent $verId');
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
      print('verifiedSuccess');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('veriFailed ${exception.message}');
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  phoneSignIn(context);
                },
              )
            ],
          );
        });
  }

  phoneSignIn(BuildContext context) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    AuthResult authResult =
    await firebaseAuth.signInWithCredential(authCredential);
    final FirebaseUser firebaseUser = await authResult.user;

    if (firebaseUser != null) {
      if(firebaseUser.phoneNumber !=null)
        {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(firebaseUser.phoneNumber)));
        }
      print(firebaseUser);
    }
  }

  Future<bool> logout() async{
    firebaseAuth..signOut();
    print("Logout");

  }
}