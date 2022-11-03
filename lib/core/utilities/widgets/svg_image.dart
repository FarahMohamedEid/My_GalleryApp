import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  const SvgImage({
    Key? key,
    required this.svgName,
    this.fit,
  }) : super(key: key);
  final String svgName;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/$svgName.svg",
      fit: fit ?? BoxFit.cover,
    );
  }
}
