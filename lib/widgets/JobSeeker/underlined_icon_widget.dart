import 'package:flutter/material.dart';

class UnderlinedIconWidget extends StatelessWidget {
  final IconData iconData;
  UnderlinedIconWidget({required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(iconData, size: 30),
      SizedBox(height: 6),
      Container(height: 4, width: 55, color: Colors.white),
    ]);
  }
}