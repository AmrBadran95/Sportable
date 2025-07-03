import 'package:flutter/material.dart';

class Globals {
  static const Color primaryBackground = Color.fromRGBO(250, 250, 250, 1);
  static const Color secondaryBackground = Color.fromRGBO(233, 226, 226, 1);
  static const Color lightFont = Color.fromRGBO(248, 248, 248, 1);
  static const Color darkFont = Color.fromRGBO(12, 12, 12, 1);
  static const Color primaryColor = Color.fromRGBO(255, 159, 47, 1);
  static const Color secondaryColor = Color.fromRGBO(255, 96, 38, 1);
  static const Color primaryLinear = Color.fromRGBO(55, 51, 30, 1);
  static const Color secondaryLinear = Color.fromRGBO(0, 0, 0, 1);

  static const double header = 48;
  static const double title = 20;
  static const double subtitle = 16;
  static const double body = 14;

  static Size fullSize(BuildContext context) => MediaQuery.of(context).size;
}
