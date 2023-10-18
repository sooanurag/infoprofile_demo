import 'package:flutter/material.dart';
import 'package:infoprofile_demo/providers/home/feeds_provider.dart';
import 'package:infoprofile_demo/providers/home/postbuttons_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/authanimate_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/getstarted_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/onboarding_provider.dart';
import 'package:infoprofile_demo/providers/theme_provider.dart';
import 'package:infoprofile_demo/services/route/route_handler.dart';
import 'package:provider/provider.dart';

import 'resources/routes.dart';
import 'services/theme/theme_handler.dart';

void main() {
  runApp(const InfoProfile());
}

class InfoProfile extends StatelessWidget {
  const InfoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => GetstartedProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AuthAnimateProvider()),
        ChangeNotifierProvider(create: (_) => FeedsProvider()),
        ChangeNotifierProvider(create: (_) => PostbuttonsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        onGenerateRoute: RouteHandler.generateRoute,
        initialRoute: Routes.feeds,
      ),
    );
  }
}
