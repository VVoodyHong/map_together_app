import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class HeaderBar extends StatelessWidget {

  // HeaderBar({

  // });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'w8kjeong',
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.bold,
            )
          ),
          Container(
            child: Icon(Icons.more_horiz),
          )
        ],
      )
    );
  }
}
