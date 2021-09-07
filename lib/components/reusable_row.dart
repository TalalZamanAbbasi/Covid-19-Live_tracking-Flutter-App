import 'package:flutter/material.dart';

class MyReusableRow extends StatelessWidget {
  final String title, value;
  MyReusableRow({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value.toString()),
          ],
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
