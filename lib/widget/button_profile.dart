import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class ButtonProfile extends StatelessWidget {

  final String title;
  final int number;
  final VoidCallback onTap;

  ButtonProfile({
    required this.title,
    required this.number,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: FontSize.medium,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox( height: 10 ),
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: FontSize.medium,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}