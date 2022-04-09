import 'package:flutter/material.dart';
import 'package:map_together/widget/base_list_tile.dart';

class BottomSheetModal {

  static Future show({
    required BuildContext context,
    required List<BaseListTile> listTiles
  }) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
        )
      ),
      builder: (context) {
        return Container(
          height: (60 * listTiles.length).toDouble(),
          color: Colors.transparent,
          child: Column(
            children: listTiles
          )
        );
      }
    );
  }
}