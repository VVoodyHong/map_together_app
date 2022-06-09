import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rating_bar;
import 'package:map_together/utils/constants.dart';

class RatingBar extends StatelessWidget {

  final double initialRating;
  final Function onRatingUpdate;
  final Icon icon;
  final bool? ignoreGestures;
  final double? itemSize;
  final double? horizonItemPadding;

  RatingBar({
    required this.initialRating,
    required this.onRatingUpdate,
    required this.icon,
    this.ignoreGestures,
    this.itemSize,
    this.horizonItemPadding
  });

  @override
  Widget build(BuildContext context) {
    return rating_bar.RatingBar.builder(
      allowHalfRating: true,
      ignoreGestures: ignoreGestures ?? false,
      itemSize: itemSize ?? 50,
      initialRating: initialRating,
      itemPadding: EdgeInsets.symmetric(horizontal: horizonItemPadding ??5),
      unratedColor: MtColor.paleGrey,
      glow: false,
      itemBuilder: (BuildContext context, int index) {
        return icon;
      },
      onRatingUpdate: (double value) {onRatingUpdate(value);}
    );
  }
}