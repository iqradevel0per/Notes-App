import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    this.controller,
    this.contentPadding,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    this.border,
    this.cursorColor,
    this.fillColor,
    this.filled,
    this.validator,
    this.isObscure = false,
  });

  TextEditingController? controller;
  EdgeInsetsGeometry? contentPadding;
  String? hintText;
  TextStyle? hintStyle;
  Widget? suffixIcon;
  InputBorder? border;
  Color? cursorColor, fillColor;
  bool? filled;
  String? Function(String?)? validator;
  bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscure,
      decoration: InputDecoration(
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: hintStyle,
          filled: filled,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          border: border,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey.shade500,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey.shade500,
              ))),
      cursorColor: cursorColor,
    );
  }
}
