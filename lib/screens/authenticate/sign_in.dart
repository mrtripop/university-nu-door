import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_door/screens/authenticate/components/background.dart';
import 'package:test_door/main_component/loading.dart';
import 'package:test_door/main_component/textField.dart';
import 'package:test_door/screens/authenticate/register.dart';
import 'package:test_door/screens/authenticate/reset_password_page.dart';
import 'package:test_door/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final firestore = FirebaseFirestore.instance;
  String error = '';
  bool loading = false;

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Background(
            child: _body(),
            padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
            logoPath: 'assets/images/logo_app.png',
            bgcolor: Color(0xffFF6433),
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
              'SIGN IN',
              style: TextStyle(
                  color: Color(0xff959595),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
              labelText: 'Username',
              hintText: 'Enter your email.',
              controller: username,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextField(
              labelText: 'Password',
              hintText: 'Enter your password.',
              obsecure: true,
              controller: password,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_buildContext) => ResetPassword()));
                },
                child: Text('Forgot Password?')),
            SizedBox(
              height: 11,
            ),
            _signInButton(),
            SizedBox(
              height: 16,
            ),
            Text('SIGN IN WITH'),
            SizedBox(
              height: 16,
            ),
            _signInGoogleButton(),
            SizedBox(
              height: 28,
            ),
            buildSignUp(),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSignUp() {
    return GestureDetector(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: 'You dot not have an account? ',
              style: TextStyle(
                  color: Color(0xFF0F2E48),
                  fontWeight: FontWeight.normal,
                  fontSize: 15)),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xFF0F2E48),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ]),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_buildContext) => Register()));
      },
    );
  }

  Widget _signInButton() {
    return OutlinedButton(
        child: Text(
          'Sign In',
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
          setState(() {
            loading = true;
          });
          dynamic result = await _auth.signInWithEmailAndPassword(
              username.text, password.text);
          // dynamic result = _test.signin(username.text, password.text);
          if (result == null) {
            setState(() {
              error = 'Could not sign in with those credentials';
              loading = false;
            });
          }
        });
  }

  Widget _signInGoogleButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(57.0))),
          minimumSize: Size(226, 60),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/icons/google_logo.png"),
                  height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
        onPressed: () async {
          setState(() {
            loading = true;
          });
          dynamic result = await _auth.signInWithGoogle();
          if (result == null) {
            setState(() {
              error = 'Could not sign in with Google Account';
              loading = false;
            });
          }
        });
  }
}
