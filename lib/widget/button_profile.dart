import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class ButtonProfile extends StatelessWidget {

  final String title;
  final String number;

  ButtonProfile({
    required this.title,
    required this.number
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          print('$title tapped');
        },
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
                number,
                style: TextStyle(
                  fontSize: FontSize.medium
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}