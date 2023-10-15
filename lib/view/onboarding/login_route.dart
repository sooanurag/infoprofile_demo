import 'package:flutter/material.dart';
import 'package:infoprofile_demo/utils/gradient_container.dart';


class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: GradientContainer(colors: [
        Colors.deepPurple.withOpacity(0.8),
        Colors.deepPurple.withOpacity(0.2)
      ]),
    ));
  }
}
