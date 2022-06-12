import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class BaseAppBar {
  final String title;
  final bool? centerTitle;
  final IconButton? leading;
  final List<Widget>? actions;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final VoidCallback? onPressedTitle;

  BaseAppBar({
    required this.title,
    this.centerTitle,
    this.leading,
    this.actions,
    this.titleColor,
    this.titleSize,
    this.titleWeight,
    this.onPressedTitle
  });

  AppBar init() {
    return AppBar(
      title: GestureDetector(
        onTap: onPressedTitle,
        child: Text(
          title,
          style: TextStyle(
            color: titleColor ?? MtColor.black,
            fontSize: titleSize ?? FontSize.large,
            fontWeight: titleWeight ?? FontWeight.w500,
          )
        ),
      ),
      backgroundColor: MtColor.white,
      elevation: 0,
      centerTitle: centerTitle ?? true,
      leading: leading,
      actions: actions,
    );
  }
}