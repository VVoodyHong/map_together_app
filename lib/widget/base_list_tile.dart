import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class BaseListTile extends StatelessWidget {

  final String title;
  final VoidCallback onTap;
  final IconData? icon;

  BaseListTile({
    required this.title,
    required this.onTap,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(
        icon,
        color: MtColor.black
      ) : null,
      title: Text(
        title,
        textAlign: icon != null ? TextAlign.start : TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500
        )
      ),
      onTap: onTap,
    );
  }
}