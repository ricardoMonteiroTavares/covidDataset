import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePicker {
  static Future<DateTime?> show(BuildContext context, DateTime selected) =>
      showDatePicker(
        context: context,
        initialDate: selected,
        firstDate: DateTime(2020, 1, 30),
        lastDate: DateTime.now(),
      );
}
