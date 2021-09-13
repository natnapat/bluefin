import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DeadLineBottomSheet extends StatefulWidget {
  const DeadLineBottomSheet({Key? key}) : super(key: key);

  @override
  _DeadLineBottomSheetState createState() => _DeadLineBottomSheetState();
}

class _DeadLineBottomSheetState extends State<DeadLineBottomSheet> {
  DateTime? _chosenDateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: CupertinoDatePicker(
              initialDateTime: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day),
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day),
              onDateTimeChanged: (val) {
                setState(() {
                  _chosenDateTime = val;
                  print(_chosenDateTime);
                });
              }),
        ),
        Container(
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    primary: Colors.white,
                    backgroundColor: Colors.amberAccent),
                onPressed: () {
                  Navigator.pop(context, _chosenDateTime);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                )))
      ],
    );
  }
}
