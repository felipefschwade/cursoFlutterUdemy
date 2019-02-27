import 'package:flutter/material.dart';

class PersonalTitle extends StatelessWidget {
  final String title;

  PersonalTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}