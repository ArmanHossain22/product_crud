import 'package:flutter/material.dart';
import 'package:to_do_application/HomePage.dart';

class CRUD extends StatelessWidget {
  const CRUD({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00327A)),
      ),
      home: const Homepage(),
    );
  }
}