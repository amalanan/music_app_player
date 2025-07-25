import 'package:flutter/material.dart';
import 'package:music_player_app/models/playlist_provider.dart';
import 'package:music_player_app/pages/home_page.dart';
import 'package:music_player_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => PlaylistProvider()),
    ],
    child: MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
