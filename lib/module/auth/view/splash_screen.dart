import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(Asset.logoSignature)
              )
            ),
          ).marginOnly(bottom: 10),
          AutoSizeText(
            "MAPTOGETHER",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: MtColor.signature
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
