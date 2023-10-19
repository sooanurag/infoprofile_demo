import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double? hzMargin;
  final Color? color;

   const GlassmorphContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.hzMargin = 20,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!),
      child: Stack(
        children: [
          //blur effect
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            // child: Container(),
          ),

          //gradient
          Container(
            margin: EdgeInsets.symmetric(horizontal: hzMargin!),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: color!.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(borderRadius!),
              gradient: LinearGradient(
                colors: [
                  color!.withOpacity(0),
                  color!.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
