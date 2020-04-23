import 'package:enis/components/surface.dart';
import 'package:flutter/material.dart';

class QuarterPickerWidget extends StatelessWidget {
  final TabController controller;
  final VoidCallback onClose;

  const QuarterPickerWidget({
    Key key,
    this.controller,
    this.onClose,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Surface(
      padding: EdgeInsets.all(0.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TabBar(
              controller: controller,
              tabs: [
                Tab(text: '1'),
                Tab(text: '2'),
                Tab(text: '3'),
                Tab(text: '4'),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
