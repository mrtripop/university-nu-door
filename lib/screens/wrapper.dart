import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_door/screens/home/home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
    print(user);

    if (user == null) {
      return SignIn();
    } else {
      return HomeScreen(
        user: user,
      );
    }
  }
}
