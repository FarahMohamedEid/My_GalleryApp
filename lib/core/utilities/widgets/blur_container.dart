import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({Key? key ,
    required this.width,
    required this.height,
    required this.child,
    required this.radius,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      decoration:BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
