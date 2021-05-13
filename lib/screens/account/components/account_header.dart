import 'package:flutter/material.dart';
import 'package:test_door/models/user_model.dart';
import 'package:test_door/screens/account/components/account_body.dart';

class Header extends StatelessWidget {
  final UserClass user;
  const Header({
    Key key,
    @required this.size,
    @required this.user,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        height: size.height * 0.2,
        child: Image.asset(
          'assets/images/home_account.png',
          width: size.width * 0.7,
        ),
      ),
      Expanded(
        child: Container(
          height: size.height,
          padding: EdgeInsets.only(top: size.height * 0.025),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: BodyAccount(user: user),
        ),
      ),
    ]);
  }
}
