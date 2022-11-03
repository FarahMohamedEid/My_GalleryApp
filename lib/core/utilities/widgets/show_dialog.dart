
import 'package:flutter/material.dart';
import 'package:my_gallery_app/core/logic/cubit/app_cubit.dart';
import 'package:my_gallery_app/core/utilities/resources/color_style.dart';

import '../resources/font_style.dart';
import '../resources/screen_size.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.rSp),
       side: const BorderSide(color: Colors.white),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                AppCubit.get(context).pikeImage();
                Navigator.pop(context);
              },
              child: Container(
                width: 184.rSp,
                height: 65.rSp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 60.rSp,
                      height: 60.rSp,
                    ),
                    Text('Gallery',
                      style:TextStyle(
                        fontFamily: FontConstants.fontFamilyLogin,
                        fontSize: 24.rSp,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorStyle.mainColor,
                      ) ,
                    ),
                  ],
                ),
                decoration:BoxDecoration(
                  color: ColorStyle.galleryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 40.rSp,
            ),
            InkWell(
              onTap: () {
                AppCubit.get(context).pikeCamera();
                Navigator.pop(context);
              },
              child: Container(
                width: 184.rSp,
                height: 65.rSp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/camera.png',
                      width: 60.rSp,
                      height: 60.rSp,
                    ),
                    Text('Camera',
                      style:TextStyle(
                        fontFamily: FontConstants.fontFamilyLogin,
                        fontSize: 24.rSp,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorStyle.mainColor,
                      ) ,
                    ),
                  ],
                ),
                decoration:BoxDecoration(
                  color: ColorStyle.cameraColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
