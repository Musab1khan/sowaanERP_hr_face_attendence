import 'package:flutter/material.dart';
import 'package:sowaanerp_hr/theme.dart';
import 'package:sowaanerp_hr/utils/app_colors.dart';

class TextFieldCircular extends StatefulWidget {
  final controller;
  final String hintText;
  int maxLines;
  bool enabled;
  TextFieldCircular(
      {this.controller,
      required this.hintText,
      this.maxLines = 1,
      this.enabled = true});

  @override
  _TextFieldCircularState createState() => _TextFieldCircularState();
}

class _TextFieldCircularState extends State<TextFieldCircular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textWhiteGrey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        onSaved: (value) {
          widget.controller.text = value;
        },
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: heading6.copyWith(color: AppColors.textGrey),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
    ;
  }
}
