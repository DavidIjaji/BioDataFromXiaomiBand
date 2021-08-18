import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "En configuraciones",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}