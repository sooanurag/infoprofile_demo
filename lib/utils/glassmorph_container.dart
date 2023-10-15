import 'dart:ui';

import 'package:flutter/material.dart';

class GlassmorphContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;

  const GlassmorphContainer({
    super.key,
    required this.child,
    this.borderRadius = 20,
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(borderRadius!),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          ),

          //child
          // Center(
          //     child: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: child,
          // )),
        ],
      ),
    );
  }
}
