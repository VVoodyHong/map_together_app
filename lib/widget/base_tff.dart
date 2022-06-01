import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_together/utils/constants.dart';

class BaseTextFormField extends StatelessWidget {
  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  final Icon? suffixIcon;
  final bool? enabled;
  final bool? multiline;
  final int? maxLines;
  final VoidCallback? onPressedIcon;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final bool? allowWhiteSpace;
  final VoidCallback? onTap;
  final int maxLength;

  BaseTextFormField({
    this.hintText,
    this.label,
    this.controller,
    this.suffixIcon,
    this.enabled,
    this.multiline,
    this.maxLines,
    this.onPressedIcon,
    this.onChanged,
    this.obscureText,
    this.allowWhiteSpace,
    this.onTap,
    required this.maxLength
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(label != null) Text(
              label ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w500
              )
            ),
            TextFormField(
              enabled: enabled,
              controller: controller,
              textAlign: TextAlign.start,
              obscureText: obscureText ?? false,
              onChanged: onChanged,
              maxLines: multiline == true ? maxLines : 1,
              maxLength: maxLength,
              keyboardType: multiline == true ? TextInputType.multiline: TextInputType.text,
              inputFormatters: allowWhiteSpace ?? true ? null : [FilteringTextInputFormatter.deny(RegExp("[ ]"))],
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MtColor.paleGrey
                  )
                ),
                disabledBorder: UnderlineInputBorder(
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
                  icon: suffixIcon!,
                ) : null
              ),
              cursorColor: MtColor.signature,
            ),
          ],
        ),
      ),
    );
  }
  
}