import 'package:flutter/material.dart';
import '../../../../core/utilities/resources/font_style.dart';
import '../../../../core/utilities/resources/screen_size.dart';
import '../resources/color_style.dart';


class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.controller,
    this.height = 45,
    this.hintMaxLines = 1,
    this.hintText = " ",
    this.autoFocus = true,
    required this.inputType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.expands = false,
    this.onSubmit,
    this.onTap,
    this.maxLines = 1,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final bool autoFocus;
  final TextInputType inputType;
  final bool obscureText;
  final Function? validator;
  final Function? onChanged;
  final ValueChanged<String>? onSubmit;
  final Function? onTap;
  final double height;
  final int hintMaxLines;
  final bool expands;
  final Icon? suffixIcon;
  final dynamic maxLines;
  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextFormField(
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        onFieldSubmitted: onSubmit,
        onTap:(){
          if(onTap != null){
            onTap!();
          }
        },
        keyboardType: inputType,
        maxLines: maxLines,
        expands: expands,
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          fontSize: 16.rSp,
          fontFamily: FontConstants.fontFamilyLogin,
          color: ColorStyle.hintColor,
          fontWeight: FontWeightManager.light,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintMaxLines: hintMaxLines,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            fontSize: 16.rSp,
            fontFamily: FontConstants.fontFamilyLogin,
            color: ColorStyle.hintColor,
            fontWeight: FontWeightManager.light,
          ),
          errorStyle: TextStyle(
            fontSize: 12.rSp,
            fontFamily: FontConstants.fontFamilyLogin,
            fontWeight: FontWeightManager.light,
          ),

          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
      ),
    );
  }
}
