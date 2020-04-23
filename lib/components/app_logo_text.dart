import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class AppLogoTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'eNIS',
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
            color: context.theme.brightness == Brightness.dark? Colors.white54 : Colors.black54,
          ),
        ),
        Text(
          'v3.0',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: context.theme.brightness == Brightness.dark? Colors.white24 : Colors.black26,
          ),
        ),
      ],
    );
  }
}
