import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:infoprofile_demo/firebase_options.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/providers/actions/createpost_provider.dart';
import 'package:infoprofile_demo/providers/home/feeds/comments_provider.dart';
import 'package:infoprofile_demo/providers/home/feeds/feeds_provider.dart';
import 'package:infoprofile_demo/providers/home/postbuttons_provider.dart';
import 'package:infoprofile_demo/providers/home/search_provider.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => GetstartedProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthAnimateProvider()),
        ChangeNotifierProvider(create: (_) => FeedsProvider()),
        ChangeNotifierProvider(create: (_) => PostbuttonsProvider()),
        ChangeNotifierProvider(create: (_) => CreatePostProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => CommentsProvider()),
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
