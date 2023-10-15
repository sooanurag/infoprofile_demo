import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../resources/fonts.dart';

class GetstartedStateOne extends StatefulWidget {
  const GetstartedStateOne({super.key});

  @override
  State<GetstartedStateOne> createState() => _GetstartedStateOneState();
}

class _GetstartedStateOneState extends State<GetstartedStateOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
                    child: DefaultTextStyle(
                      style: AppFonts.headerStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      child:
                          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                        FadeAnimatedText("hey!",
                            duration: const Duration(seconds: 3)),
                        FadeAnimatedText("Welcome to\ninfoprofile!",
                            duration: const Duration(seconds: 3),
                            textAlign: TextAlign.center),
                      ]),
                    ),
                  );
  }
}