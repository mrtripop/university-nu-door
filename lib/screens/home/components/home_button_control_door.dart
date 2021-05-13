import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_door/constants.dart';

class ButtonControlDoor extends StatelessWidget {
  final String stateDoor;
  final Function onPressed;
  ButtonControlDoor({
    this.stateDoor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return OutlinedButton(
      child: stateDoor != 'OPEN'
          ? SvgPicture.asset(
              'assets/icons/lock_icon.svg',
              width: screen.width * 0.3,
            )
          : SvgPicture.asset('assets/icons/unlock_icon.svg',
              width: screen.width * 0.3),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        side: MaterialStateProperty.all(BorderSide(
            width: 4,
            color: stateDoor != "OPEN"
                ? Colors.white.withOpacity(0.2)
                : Colors.blue.withOpacity(0.2),
            style: BorderStyle.solid)),
        minimumSize: MaterialStateProperty.all(Size(200, 200)),
        shadowColor: MaterialStateProperty.all(appBarBGcolor.withOpacity(0.7)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(120.0),
        )),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(5.0),
      ),
      onPressed: onPressed,
    );
  }
}
