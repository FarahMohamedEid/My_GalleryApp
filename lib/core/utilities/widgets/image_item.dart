import 'package:flutter/material.dart';

import '../resources/screen_size.dart';

class ImageItem extends StatelessWidget {
  ImageItem({Key? key,
  required this.imagePath,
  }) : super(key: key);

  String imagePath;
  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: 108.rSp,
      height: 108.rSp,
      decoration:BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
