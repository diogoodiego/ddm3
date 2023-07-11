import 'package:ddm3/src/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DDM3',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
