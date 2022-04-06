import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class BaseTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Icon? suffixIcon;
  final bool? enabled;
  final bool? multiline;
  final VoidCallback? onPressedIcon;

  BaseTextFormField({
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.enabled,
    this.multiline,
    this.onPressedIcon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        textAlign: TextAlign.start,
        maxLines: multiline == true ? null : 1,
        keyboardType: multiline == true ? TextInputType.multiline: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: MtColor.paleGrey
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: MtColor.signature
            )
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: MtColor.grey
          ),
          suffixIcon: suffixIcon != null ? IconButton(
            onPressed: onPressedIcon,
            icon: suffixIcon!
          ) : null
        ),
        cursorColor: MtColor.signature,
      ),
    );
  }
  
}