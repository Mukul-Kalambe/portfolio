import 'package:flutter/material.dart';
import 'package:myportfolio/portfolio_home_page.dart';
import 'package:myportfolio/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mukul Kalambe - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const PortfolioHomePage(),
    );
  }
}
