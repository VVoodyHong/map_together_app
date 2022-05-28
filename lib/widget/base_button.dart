import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class BaseButton {
  
  static IconButton iconButton({
    required IconData iconData,
    required Function() onPressed,
    Color? color
  }) {
    return IconButton(
      icon: Icon(
        iconData,
        color: color ?? MtColor.black,
      ),
      splashRadius: 24,
      onPressed: onPressed,
    );
  }

  static IconButton textButton({
    required String text,
    required Function() onPressed
  }) {
    return IconButton(
      icon: Text(
        text,
        style: TextStyle(
          color: MtColor.black,
        )
      ),
      splashRadius: 24,
      onPressed: onPressed,
    );
  }
}