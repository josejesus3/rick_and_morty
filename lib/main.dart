import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/config/router/go_router.dart';
import 'package:rick_and_morty/config/theme/app_theme.dart';


void main() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, // Color de la barra de estado
    statusBarIconBrightness: Brightness.light, // Color de los iconos de la barra de estado
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '  Rick  and Morty  ',
      theme: AppTheme(selectColor: 1).getTheme(),
      routerConfig: appRouter
    );
  }
}
