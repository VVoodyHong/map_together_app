
import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {

  final String label;
  final VoidCallback onTap;

  ButtonText({
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600]
          )
        ),
      ),
    );
  }
}