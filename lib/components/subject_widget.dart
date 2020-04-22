import 'package:enis/components/percent_widget.dart';
import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

class SubjectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0.0, 8.0),
            blurRadius: 12.0,
          )
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Физическая культура',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PercentWidget(percentage: 90.87),
                          GradeWidget(grade: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.yellow.withOpacity(0.25),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  value: 90.87 / 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
