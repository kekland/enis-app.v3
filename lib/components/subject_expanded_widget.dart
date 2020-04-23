import 'package:enis/api/data/diary_data.dart';
import 'package:enis/api/hl_api.dart';
import 'package:enis/components/evaluation_data_widget.dart';
import 'package:enis/components/subject_widget.dart';
import 'package:enis/utils.dart';
import 'package:flutter/material.dart';

class SubjectExpandedWidget extends StatefulWidget {
  final SubjectData data;

  const SubjectExpandedWidget({Key key, this.data}) : super(key: key);
  @override
  _SubjectExpandedWidgetState createState() => _SubjectExpandedWidgetState();
}

class _SubjectExpandedWidgetState extends State<SubjectExpandedWidget> {
  SubjectExpandedData _data;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => load());
  }

  load() async {
    runAsyncTaskWithoutIndicator(
      context: context,
      task: () async {
        _data = await HighLevelApi.getExpandedSubjectInfo(subject: widget.data);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 12.0),
        Container(
          width: 32.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SubjectWidget(data: widget.data, clickable: false),
                SizedBox(height: 16.0),
                if (_data == null) CircularProgressIndicator(),
                if (_data != null)
                  ..._data.evaluationData.map(
                    (v) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: EvaluationDataWidget(data: v),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
