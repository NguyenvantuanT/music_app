import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/pages/Account_page.dart';
import 'package:music_app/pages/Discovery_page.dart';
import 'package:music_app/pages/Home_music_page.dart';
import 'package:music_app/pages/Settings_page.dart';
import 'package:music_app/themes/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _tabs = const [
    HomeMusicPage(),
    DiscoveryPage(),
    AccountPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.album), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ]),
          tabBuilder: (context, index) {
            return _tabs[index];
          }),
    );
  }
}
