import 'package:flutter/material.dart';
import 'package:music_app/pages/home_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // var repository = DefaultRepository();
  // var songs = await repository.loadData();
  // if(songs != null){
  //   for(var song in songs){
  //     debugPrint(song.toString());
  //   }
  // }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
