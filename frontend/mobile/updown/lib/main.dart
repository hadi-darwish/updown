import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:updown/providers/building_provider.dart';
import 'package:updown/providers/guest_provider.dart';
import 'package:updown/screens/guest_mode_login_screen.dart';
import 'package:updown/screens/guest_screen.dart';
import 'package:updown/screens/home_sceen.dart';
import 'package:updown/screens/sign_in_screen.dart';

import 'package:updown/widgets/button.dart';
import 'package:updown/widgets/input.dart';
import 'package:updown/widgets/top_bar.dart';

Future main() async {
  await dotenv.load(
      fileName: '.env'); // This is where you can store your API keys
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Guest()),
        ChangeNotifierProvider(create: (context) => Building()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: const Color.fromRGBO(245, 244, 244, 1),
          fontFamily: 'Nunito',
          cardColor: const Color.fromRGBO(89, 219, 174, 1),
          primaryColor: const Color.fromRGBO(0, 48, 63, 1),
          primaryColorLight: const Color.fromRGBO(0, 48, 63, 0.5),
          secondaryHeaderColor: const Color.fromRGBO(89, 219, 174, 1),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromRGBO(89, 219, 174, 1),
            selectionColor: Color.fromRGBO(89, 219, 174, 1),
            selectionHandleColor: Color.fromRGBO(0, 48, 63, 1),
          ),
        ),
        home: const SignIn(),
        routes: {
          '/signIn': (context) => const SignIn(),
          '/guestModeLogin': (context) => const GuestModeLogin(),
          '/home': (context) => const Home(),
          '/guestMode': (context) => const GuestPage(),
        },
      ),
    );
  }
}
