import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/actions/createpost_provider.dart';
import 'package:infoprofile_demo/providers/home/feeds_provider.dart';
import 'package:infoprofile_demo/providers/home/postbuttons_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/authanimate_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/getstarted_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/onboarding_provider.dart';
import 'package:infoprofile_demo/providers/theme_provider.dart';
import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/services/route/route_handler.dart';
import 'package:provider/provider.dart';

import 'resources/routes.dart';
import 'services/theme/theme_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefrencesSettings settings = await PrefrenceService().getPrefrences();

  runApp(InfoProfile(
    settings: settings,
  ));
}

class InfoProfile extends StatelessWidget {
  final PrefrencesSettings settings;
  const InfoProfile({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    //debug-print
    debugPrint('${settings.username}: ${settings.accesstoken}');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => GetstartedProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AuthAnimateProvider()),
        ChangeNotifierProvider(create: (_) => FeedsProvider()),
        ChangeNotifierProvider(create: (_) => PostbuttonsProvider()),
        ChangeNotifierProvider(create: (_) => CreatePostProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        onGenerateRoute: RouteHandler.generateRoute,
        initialRoute:
            (settings.accesstoken != null) ? Routes.feeds : Routes.getstarted,
      ),
    );
  }
}
