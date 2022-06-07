import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as ratingBar;
import 'package:map_together/utils/constants.dart';

class RatingBar extends StatelessWidget {

  final double initialRating;
  final Function onRatingUpdate;
  final Icon icon;

  RatingBar({
    required this.initialRating,
    required this.onRatingUpdate,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return ratingBar.RatingBar.builder(
      allowHalfRating: true,
      itemSize: 50,
      initialRating: initialRating,
      itemPadding: EdgeInsets.symmetric(horizontal: 5),
      unratedColor: MtColor.paleGrey,
      glow: false,
      itemBuilder: (BuildContext context, int index) {
        return icon;
      },
      onRatingUpdate: (double value) {onRatingUpdate(value);}
    );
  }
}