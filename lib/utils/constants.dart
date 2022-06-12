import 'package:flutter/material.dart';
import 'package:map_together/model/type/place_category_type.dart';

class MtColor {
  static const signature = Color(0xFF2DB9F3);
  static const transparent = Colors.transparent;
  static const black = Colors.black;
  static const paleBlack = Colors.black54;
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const red = Colors.red;
  static const paleGrey = Color(0xFFEEEEEE);
  static const kakao = Color(0xffffe812);
}

class FontSize {
  static const small = 12.0;
  static const medium = 16.0;
  static const large = 20.0;
}

class ZoomLevel {
  static const min = 5.70;
  static const max = 19.00;  
}

class DefaultPosition {
  static const lat = 35.94841985643522;
  static const lng = 127.68575755041469;
  static const zoom = 5.70;
}

class Asset {
  static const defaultProfile = 'lib/assets/images/default_profile.png';

  // markers

  static const markers = [
    PlaceCategoryType.AIRPLANE,
    PlaceCategoryType.BEER,
    PlaceCategoryType.COFFEE,
    PlaceCategoryType.DESSERT,
    PlaceCategoryType.HEART,
    PlaceCategoryType.MARKER,
    PlaceCategoryType.RICE,
    PlaceCategoryType.SPORTS,
    PlaceCategoryType.STAR,
  ];

  static const airplane = 'lib/assets/markers/airplane.png';
  static const beer = 'lib/assets/markers/beer.png';
  static const coffee = 'lib/assets/markers/coffee.png';
  static const dessert = 'lib/assets/markers/dessert.png';
  static const heart = 'lib/assets/markers/heart.png';
  static const marker = 'lib/assets/markers/marker.png';
  static const rice = 'lib/assets/markers/rice.png';
  static const sports = 'lib/assets/markers/sports.png';
  static const star = 'lib/assets/markers/star.png';

  String getMarker(String name) {
    switch (name) {
      case 'AIRPLANE':
        return airplane;
      case 'BEER':
        return beer;
      case 'COFFEE':
        return coffee;
      case 'DESSERT':
        return dessert;
      case 'HEART':
        return heart;
      case 'MARKER':
        return marker;
      case 'RICE':
        return rice;
      case 'SPORTS':
        return sports;
      case 'STAR':
        return star;
      default:
        return '';
    }
  }
}

class DefaultPage {
  static const size = 20;
}