import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laoding Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitCubeGrid(
            size:100,
            duration: Duration(seconds:2),
            itemBuilder: (context, index){
              final colors = [Colors.pink[100], Colors.pinkAccent, Colors.pink];
              final color = colors[index % colors.length];
           return DecoratedBox(decoration: BoxDecoration(color:color,
           shape: BoxShape.rectangle));
            }
          ),
        ),
      )
    );
  }
}
