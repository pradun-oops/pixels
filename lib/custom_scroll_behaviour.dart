import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomScrollBehaviour extends MaterialScrollBehavior {
  Set<PointerDeviceKind> get dragdevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
