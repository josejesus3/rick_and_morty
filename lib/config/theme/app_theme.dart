import 'package:flutter/material.dart';

List<Color> colorsList = [
  Colors.black,
  Colors.white,
  Colors.blue,
  Colors.green,
];

class AppTheme {
  final int selectColor;

  AppTheme({this.selectColor = 0})
      : assert(selectColor >= 0, 'SelectColor entre 0 y ${colorsList.length}'),
        assert(selectColor < colorsList.length,
            'Seleccolors menor que ${colorsList.length}');

  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: colorsList[selectColor]);
}
