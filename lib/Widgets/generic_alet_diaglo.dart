import 'package:flutter/material.dart';

Future<dynamic> showGenericAlertDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  List<Map<String, T>>? buttonsAndWhatTheyReturn,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      List<Widget> myWidgetList = [];
      if (buttonsAndWhatTheyReturn != null &&
          buttonsAndWhatTheyReturn.isNotEmpty) {
        for (var buttonMap in buttonsAndWhatTheyReturn) {
          String key = buttonMap.keys.first;
          final myTextButton = Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightGreen)),
              onPressed: () {
                Navigator.of(context).pop(buttonMap[key]);
              },
              child: Text(
                key,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
          myWidgetList.add(myTextButton);
        }
      }
      return AlertDialog(
          title: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: myWidgetList,
              )
            ],
          ));
    },
  );
}
