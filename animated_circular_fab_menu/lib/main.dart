import 'package:animated_circular_fab_menu/page/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Animated FAB Menu',
     theme: ThemeData( primarySwatch: Colors.indigo),
     debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
