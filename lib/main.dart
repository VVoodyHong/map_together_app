import 'package:flutter/material.dart';

void main() {
  runApp(MapTogether());
}

class MapTogether extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map Together'),
        ),
        body: Container(),
      ),
    );
  }

}
