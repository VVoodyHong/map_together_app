import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class FinderBox extends StatelessWidget{
  final String? hintText;
  final TextEditingController controller;
  final VoidCallback onSearch;
  final bool hasValue;
  final ValueChanged<String> onChanged;
  final VoidCallback clear;

  FinderBox({
    this.hintText,
    required this.controller,
    required this.onSearch,
    required this.hasValue,
    required this.onChanged,
    required this.clear,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      cursorColor: MtColor.grey,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        border: InputBorder.none,
        enabledBorder: _border(),
        focusedBorder: _border(),
        hintStyle: TextStyle(
          color: MtColor.grey,
        ),
        filled: true,
        fillColor: MtColor.paleGrey,
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: hasValue
        ? IconButton(
            onPressed: clear,
            icon: Icon(Icons.close, color: MtColor.grey),
            splashColor: Colors.transparent,
          )
        : IconButton(
            onPressed: () {search(context); },
            icon: Icon(Icons.search, color: MtColor.grey),
            splashColor: Colors.transparent,
          )
      ),
      maxLength: 20,
      onChanged: onChanged,
      onEditingComplete: () {search(context); },
      textInputAction: TextInputAction.done,
    );
  }

  void search(context) {
    onSearch();
    FocusScope.of(context).unfocus();
  }

  OutlineInputBorder _border(){
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(50)
    );
  }
}
