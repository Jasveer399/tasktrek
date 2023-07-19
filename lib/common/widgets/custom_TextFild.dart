import 'package:flutter/material.dart';
import 'package:tasktrek/common/utils/constants.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {super.key,
      this.keyboardType,
      required this.controller,
      this.onChanged,
      this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.prefixIcon,
      this.labelText,
      this.labelStyle,
      this.style});

  final TextInputType? keyboardType;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.khight * 0.07,
      width: AppConst.kwidth * 0.85,
      decoration: BoxDecoration(
        color: AppConst.KLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: style,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        cursorHeight: 25,
        cursorColor: AppConst.KBkdark,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
          hintText: hintText,
          hintStyle: hintStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: AppConst.KBkdark,
          prefixIconColor: AppConst.KBkdark,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.KGreyDk, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppConst.KBkdark, width: 0.5),
          ),
        ),
      ),
    );
  }
}
