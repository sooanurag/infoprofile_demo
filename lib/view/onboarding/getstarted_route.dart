import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infoprofile_demo/components/onboarding/auth/auth_signin_state.dart';
import 'package:infoprofile_demo/components/onboarding/getstarted/getstarted_state_two.dart';
import 'package:infoprofile_demo/components/onboarding/getstarted/getstarted_stateone.dart';
import 'package:infoprofile_demo/providers/onboarding/getstarted_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';

import 'package:infoprofile_demo/utils/gradient_container.dart';

import 'package:provider/provider.dart';

class GetStartedRoute extends StatefulWidget {
  const GetStartedRoute({super.key});

  @override
  State<GetStartedRoute> createState() => _GetStartedRouteState();
}

class _GetStartedRouteState extends State<GetStartedRoute> {
  @override
  void initState() {
    final getStartedProvider =
        Provider.of<GetstartedProvider>(context, listen: false);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.initState();
    Timer(const Duration(seconds: 7), () {
      getStartedProvider.setIsWelcomed(status: true);
    });
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        GradientContainer(colors: [Colors.black, AppColors.darkPruple]),
        Consumer<GetstartedProvider>(
          builder: (context, value, child) {
            return (value.isAuth)? const AuthSignInState()
            :(value.isWelcomed)
                ? GetstartedStateTwo(screenSize: screenSize)
                : const GetstartedStateOne();
          },
        ),
      ]),
    );
  }
}
