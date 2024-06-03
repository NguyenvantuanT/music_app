import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/pages/Home_music_page.dart';
import 'package:music_app/themes/theme.dart';

void main() async {
    SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeMusicPage());
  }
}
