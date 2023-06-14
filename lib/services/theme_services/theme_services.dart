import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
class themeServices{
  final _box=GetStorage();
  //getstorage store data in key value pair and initially the below key will be null
  final _key='isDarkMode';


  bool _loadingThemeFromBox()=>_box.read(_key)??false;
  _saveThemeToBox(bool isDarkMode)=>_box.write(_key, isDarkMode);

  //get is a package by using which you can call any variable or method without making any
  //extra import statements and this have return type of theme mode because it will return theme mode
  //either light or dark
  ThemeMode get theme=>_loadingThemeFromBox()?ThemeMode.dark:ThemeMode.light;


  void switchTheme(){
    Get.changeThemeMode(_loadingThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadingThemeFromBox());
  }

}
