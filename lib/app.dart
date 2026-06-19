import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/theme.dart';
import 'navigation/app_router.dart';

class GameSpaceApp extends StatelessWidget {
  const GameSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF050B14),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Game Space Pro',
      debugShowCheckedModeBanner: false,
      theme: GSTheme.darkTheme,
      home: const AppRouter(),
    );
  }
}
