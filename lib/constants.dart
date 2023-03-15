import 'package:flutter/material.dart';

class Constants {
  BuildContext context;
  Constants(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}
