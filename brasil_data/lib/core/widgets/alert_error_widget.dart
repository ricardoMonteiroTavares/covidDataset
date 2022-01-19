import 'package:flutter/material.dart';

class AlertErrorWidget extends StatelessWidget {
  final String? msg;
  final double minHeight, maxHeight, minWidth, maxWidth;
  const AlertErrorWidget({
    Key? key,
    @required this.msg,
    this.minHeight = 0.0,
    this.maxHeight = double.infinity,
    this.minWidth = 0.0,
    this.maxWidth = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: msg == null ? false : true,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(5),
        constraints: BoxConstraints(
          minHeight: minHeight,
          maxHeight: maxHeight,
          minWidth: minWidth,
          maxWidth: maxWidth,
        ),
        decoration: BoxDecoration(
          color: Colors.redAccent[100],
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Text(
          msg ?? '',
          style: TextStyle(color: Colors.red[800]),
        ),
      ),
    );
  }
}
