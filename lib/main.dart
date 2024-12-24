import 'package:flutter/material.dart';
import 'package:pixels/custom_scroll_behaviour.dart';
import 'package:pixels/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehaviour(),
      title: 'Pixels',
      home: const HomePage(),
    );
  }
}
