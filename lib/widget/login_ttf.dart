import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class LoginTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? multiline;
  final bool? obscureText;

  LoginTextFormField({
    this.hintText,
    this.controller,
    this.multiline,
    this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            textAlign: TextAlign.start,
            maxLength: 64,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              counterText: '',
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
              )
            ),
            cursorColor: MtColor.signature,
          ),
        ],
      ),
    );
  }
  
}