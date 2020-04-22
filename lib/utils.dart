import 'package:flutter/material.dart';
import 'package:enis/extensions.dart';

void showScaffoldError(BuildContext context, dynamic e) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      'Произошла ошибка',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Подробнее',
      textColor: Colors.white,
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: Text('Произошла ошибка'),
            content: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('Закрыть'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    ),
  ));
}

showLoadingDialog(BuildContext context, [Function onClosed]) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Center(
      child: Container(
        width: 72.0,
        height: 72.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.theme.cardColor,
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    ),
  ).then((_) {
    if (onClosed != null) onClosed();
  });
}

Future<void> runAsyncTask({
  BuildContext context,
  Future Function() task,
}) async {
  bool shouldPop = true;
  try {
    showLoadingDialog(context, () => shouldPop = false);
    await task();
  } catch (e) {
    showScaffoldError(context, e);
  } finally {
    if (shouldPop) Navigator.pop(context);
  }
}
