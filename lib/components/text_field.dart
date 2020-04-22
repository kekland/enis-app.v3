import 'package:flutter/material.dart';

class BeautifulTextField extends StatelessWidget {
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final String hint;
  final IconData icon;

  const BeautifulTextField({
    Key key,
    this.borderRadius,
    this.hint,
    this.icon,
    this.controller,
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
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class BeautifulSelect extends StatelessWidget {
  final BorderRadius borderRadius;
  final String hint;
  final IconData icon;
  final String selected;
  final Function(String) onSelected;
  final List<DropdownMenuItem> items;

  const BeautifulSelect({
    Key key,
    this.borderRadius,
    this.hint,
    this.icon,
    this.items,
    this.selected,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(width: 12.0),
          Icon(icon, color: Colors.white70),
          SizedBox(width: 12.0),
          Flexible(
            child: DropdownButton(
              items: items,
              underline: Container(),
              hint: Text(hint),
              onChanged: (v) => onSelected(v),
              isExpanded: true,
              value: selected,
            ),
          ),
        ],
      ),
    );
  }
}
