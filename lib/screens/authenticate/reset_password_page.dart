import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_door/screens/authenticate/components/background.dart';
import 'package:test_door/main_component/textField.dart';
import 'package:test_door/services/auth.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final username = TextEditingController();
  String errorStatus;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: _body(),
      logoPath: 'assets/images/logo_app.png',
      padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
    );
  }

  Widget _body() {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RESET PASSWORD',
              style: TextStyle(
                  color: Color(0xff959595),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              'Note: การเปลี่ยนรหัสผ่าน ท่านสามารถแก้ไขรหัสผ่านได้โดยการ Verify Email',
              style: TextStyle(color: Color(0xffFF8D8D)),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              labelText: 'Username',
              hintText: 'Enter your email.',
              controller: username,
            ),
            SizedBox(
              height: 32,
            ),
            _sendButton(),
            SizedBox(
              height: 60,
            ),
            _buildSignIn(),
          ],
        ),
      ),
    );
  }

  Widget _sendButton() {
    return OutlinedButton(
        child: Text(
          'Send',
          style: TextStyle(fontSize: 18),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Color(0xff0087E2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(57.0))),
          minimumSize: Size(226, 60),
        ),
        onPressed: () async {
          dynamic result = _auth.sendPasswordResetEmail(username.text);
          if (result == null) {
            setState(() {
              errorStatus = 'Email is invalid.';
            });
          } else {
            Navigator.of(context).pop();
            dialog();
          }
        });
  }

  Widget dialog() {
    return CupertinoAlertDialog(
      title: Text('Success!'),
      content: Text('Great! You already!'),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
        ),
      ],
    );
  }

  GestureDetector _buildSignIn() {
    return GestureDetector(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: 'You have an account? ',
              style: TextStyle(
                  color: Color(0xFF0F2E48),
                  fontWeight: FontWeight.normal,
                  fontSize: 15)),
          TextSpan(
              text: 'Sign In',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xFF0F2E48),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ]),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
