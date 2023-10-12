import 'package:flutter/material.dart';
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
      ],
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          onGenerateRoute: RouteHandler.generateRoute,
          initialRoute: Routes.splash,
        );
      }),
    );
  }
}
