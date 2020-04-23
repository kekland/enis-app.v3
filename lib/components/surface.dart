import 'package:flutter/material.dart';
import '../extensions.dart';

class Surface extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const Surface({
    Key key,
    this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0.0, 8.0),
            blurRadius: 12.0,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
