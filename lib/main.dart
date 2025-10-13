import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myportfolio/portfolio_home_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PortfolioHomePage(),
    );
  }
}
