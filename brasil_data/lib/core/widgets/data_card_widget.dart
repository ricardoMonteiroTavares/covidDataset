import 'package:flutter/material.dart';

class DataCardWidget extends StatelessWidget {
  final String title;
  final int? value;
  final double aspectRatio;
  final Color color;
  const DataCardWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.aspectRatio,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontSize: 17, color: color))
              ],
            ),
            (value == null)
                ? CircularProgressIndicator(color: color)
                : Text(
                    value.toString(),
                    style: TextStyle(
                        fontSize: 50,
                        color: color,
                        fontWeight: FontWeight.bold),
                  ),
            SizedBox(
              height: aspectRatio * 5,
            )
          ],
        ),
      ),
    );
  }
}
