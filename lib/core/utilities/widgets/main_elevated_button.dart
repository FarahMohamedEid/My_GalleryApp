import 'package:flutter/material.dart';
import 'package:my_gallery_app/core/utilities/resources/font_style.dart';

import '../resources/screen_size.dart';


class MainElevatedButton extends StatelessWidget {
  const MainElevatedButton({
    Key? key,
    required this.onPressed,
    required this.color,
    required this.text,
    this.borderColor,
    this.textColor,
    this.loading = false,
    this.icon,
  }) : super(key: key);
  final Function onPressed;
  final Color color;
  final Color? borderColor, textColor;
  final String text;
  final bool loading;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!loading) onPressed();
        },
        child: Center(
          child: loading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: textColor ?? Colors.white,
                    strokeWidth: 3,
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18.rSp,
                        fontFamily: FontConstants.fontFamilyLogin,
                        color: Colors.white,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    if (icon != null)
                      const SizedBox(
                        width: 10,
                      ),
                    if (icon != null) icon!
                  ],
                ),
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor ?? color),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
