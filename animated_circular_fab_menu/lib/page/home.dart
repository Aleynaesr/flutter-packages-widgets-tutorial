import 'package:animated_circular_fab_menu/utils/constant.dart';
import 'package:animated_circular_fab_menu/widget/circular_fab_widget.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Float Action Button",),
        backgroundColor: primary,
      ),
      floatingActionButton: CircularFabWidget(),
    );
  }
}
