import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:map_together/utils/constants.dart';

class EmptyView extends StatelessWidget {
  final String text;

  EmptyView({
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: MtColor.paleBlack,
            )
          )
      ]),
    );
  }
}