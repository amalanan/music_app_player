import 'package:flutter/material.dart';
import 'package:music_player_app/themes/light_mode.dart';
import 'package:music_player_app/themes/dark_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;


  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners(); // update UI
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }

}