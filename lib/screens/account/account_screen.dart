import 'package:flutter/material.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/account/components/account_header.dart';
import 'package:test_door/screens/account/components/account_button_focus_menu.dart';

import '../../constants.dart';

class AccountScreen extends StatelessWidget {
  final UserClass user;

  const AccountScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: appBarBGcolor,
        child: Header(
          size: size,
          user: user,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ButtonFocusMenu(
        size: size,
        user: user,
      ),
    );
  }
}
