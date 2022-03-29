import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return Center(
        child: Text("MAP TOGETHER",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: MtColor.signature)));
  }
}
