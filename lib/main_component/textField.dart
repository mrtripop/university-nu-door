import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool obsecure;
  final Color colorTextField;
  final Color colorShadow;
  final String labelText;
  final String hintText;
  final String errorText;
  final bool openPass;
  final bool openSuffix;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final TextEditingController controller;
  final bool enabled;

  const MyTextField({
    Key key,
    this.colorShadow,
    this.prefixIcon,
    this.suffixIcon,
    this.obsecure,
    this.colorTextField,
    this.labelText,
    this.hintText,
    this.errorText,
    this.enabled,
    this.openPass = true,
    this.openSuffix = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(36)),
        border: Border.all(color: Colors.black12, width: 1.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: colorShadow != null
                ? colorShadow
                : Color(0xffC8C8C8).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.center,
        enabled: enabled,
        controller: controller,
        obscureText: obsecure != null ? obsecure : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(36.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(36)),
          //     borderSide: BorderSide(
          //       style: BorderStyle.solid,
          //       color: Color(0xffC8C8C8),
          //     )),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText != null ? labelText : 'labelText',
          labelStyle: TextStyle(color: Color(0xff959595)),
          fillColor: colorTextField != null ? colorTextField : Colors.white,
          filled: true,
          hintText: hintText != null ? hintText : 'hintText',
          hintStyle: TextStyle(color: Color(0xffBEBEBE)),
          errorText: errorText != null ? errorText : null,
        ),
      ),
    );
  }
}
