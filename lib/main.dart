import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/actions/createpost_provider.dart';
import 'package:infoprofile_demo/providers/home/feeds_provider.dart';
import 'package:infoprofile_demo/providers/home/postbuttons_provider.dart';
import 'package:infoprofile_demo/providers/home/search_provider.dart';

import 'package:infoprofile_demo/providers/onboarding/authanimate_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/auth_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/getstarted_provider.dart';
import 'package:infoprofile_demo/providers/onboarding/onboarding_provider.dart';
import 'package:infoprofile_demo/providers/theme_provider.dart';

import 'package:infoprofile_demo/services/prefrences_service.dart';
import 'package:infoprofile_demo/services/route/route_handler.dart';
import 'package:infoprofile_demo/view/home/feeds_route.dart';
import 'package:infoprofile_demo/view/onboarding/getstarted_route.dart';
import 'package:provider/provider.dart';
import 'services/theme/theme_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefrencesSettings settings = await PrefrenceService().getPrefrences();

  await dotenv.load(fileName: '.env');

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
    debugPrint(
        '${settings.username}: ${settings.accesstoken}\n user id: ${settings.userId}');
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
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        onGenerateRoute: RouteHandler.generateRoute,
        home: (settings.accesstoken != null)?  FeedsRoute(prefrencesSettings: settings,): const GetStartedRoute(),
      ),
    );
  }
}
