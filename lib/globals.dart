  import 'package:flutter/material.dart';

Color colorFromDamageLevel(int level) {
  print(level);
    switch (level) {
      case 5:
        return Colors.red;
      case 4:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 2:
        return Colors.lightGreen;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  double intensity = 5.0;