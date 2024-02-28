import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  //buat variabel pertama
  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //kedua buat codingan ini
            Text(_dateTime == null
                ? 'Nothing has been picked yet'
                : _dateTime.toString()),
          ],
        ),
      ),
    );
  }
}
