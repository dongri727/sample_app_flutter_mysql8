import 'package:flutter/material.dart';

import 'top_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MySQL8 Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TopPage(),
    );
  }
}