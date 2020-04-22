import 'package:flutter/material.dart';

class BeautifulTextField extends StatelessWidget {
  final BorderRadius borderRadius;
  final String hint;
  final IconData icon;

  const BeautifulTextField({
    Key key,
    this.borderRadius,
    this.hint,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
