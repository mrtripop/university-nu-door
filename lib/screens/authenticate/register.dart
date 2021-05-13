import 'package:flutter/cupertino.dart';
import 'package:test_door/constants.dart';
import 'package:test_door/main_component/textField.dart';
import 'package:test_door/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarBGcolor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: size.width,
              decoration: BoxDecoration(
                  color: appBarBGcolor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36))),
              child: Center(
                child: Text(
                  'REGISTER',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BodyForm(),
            Spacer()
          ],
        ),
      ),
    );
  }
}

class BodyForm extends StatefulWidget {
  const BodyForm({Key key}) : super(key: key);

  @override
  _BodyFormState createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  final AuthService _auth = AuthService();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final name = TextEditingController();
  String errorStatus;
  String titleAlert;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              form(),
              SizedBox(height: 40),
              _signUpButton(context),
              SizedBox(height: 20),
              _buildSignIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        MyTextField(
          labelText: 'Name Lastname',
          hintText: 'Enter your name',
          controller: name,
        ),
        SizedBox(
          height: 15,
        ),
        MyTextField(
          labelText: 'Username',
          hintText: 'Enter your email.',
          controller: username,
        ),
        SizedBox(
          height: 15,
        ),
        MyTextField(
          labelText: 'Password',
          hintText: 'Enter your password.',
          obsecure: true,
          controller: password,
        ),
        SizedBox(
          height: 15,
        ),
        MyTextField(
          labelText: 'Confirm Password',
          hintText: 'Enter your password again.',
          obsecure: true,
          controller: confirmPassword,
        ),
      ],
    );
  }

  Widget _signUpButton(BuildContext context) {
    return OutlinedButton(
        child: Text(
          'Sign Up',
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
          bool signUpStatus = _checkPassword();
          if (signUpStatus) {
            dynamic result = await _auth.registerWithEmailAndPassword(
                username.text, password.text, name.text, "");
            if (result != null) {
              setState(() {
                titleAlert = 'Sign Up';
                errorStatus = 'Success!';
              });
              Navigator.of(context).pop();
            } else {
              setState(() {
                titleAlert = 'Sign Up';
                errorStatus = 'Could not sign in with this email.';
              });
            }
            _showMyDialog();
          }
        });
  }

  Future _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$titleAlert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$errorStatus'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _checkPassword() {
    if (password.text != confirmPassword.text) {
      setState(() {
        titleAlert = 'Wrong!';
        errorStatus = 'Password not correct.';
      });
      return false;
    } else {
      setState(() {
        titleAlert = null;
        errorStatus = null;
      });
      return true;
    }
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
