import 'package:flutter/material.dart';
import 'package:propel_login/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'CenturySchoolbook',
          primarySwatch: const MaterialColor(0xFF9900FF, <int, Color>{
            50: Color(0xFFE6C6FF),
            100: Color(0xFFC19AFF),
            200: Color(0xFF9D6DFF),
            300: Color(0xFF783FFF),
            400: Color(0xFF561CFF),
            500: Color(0xFF3400FF),
            600: Color(0xFF2F00E6),
            700: Color(0xFF2900BF),
            800: Color(0xFF220099),
            900: Color(0xFF1C0073),
          })
      ),
      home:  SplashScreen(),
    );
  }
}

