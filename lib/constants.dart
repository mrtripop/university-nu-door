import 'package:flutter/material.dart';

// Colors that we use in our app
const kPrimaryColor = Color(0xFF3498DB);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFffffff);
const appBarBGcolor = Color(0xff0066cc);

const cardColorArray = [
  [
    Color(0xffff6666),
    Color(0xffff6699),
  ],
  [
    Color(0xff9966ff),
    Color(0xffcc66ff),
  ],
];

const double kDefaultPadding = 20.0;

const TextStyle cardDefaultTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const TextStyle cardHeaderTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

const order_processed = "assets/images/order_processed.svg";
const order_confirmed = "assets/images/order_confirmed.svg";
const order_shipped = "assets/images/order_shipped.svg";
const order_onTheWay = "assets/images/on_the_way.svg";
const order_delivered = "assets/images/delivered.svg";
