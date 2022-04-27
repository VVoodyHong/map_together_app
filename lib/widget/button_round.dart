import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class ButtonRound extends StatelessWidget {

  final String label;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? textColor;

  ButtonRound({
    required this.label,
    required this.onTap,
    this.buttonColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor ?? MtColor.signature,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}