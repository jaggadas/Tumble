import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swipable/flutter_swipable.dart';

import 'package:flutter_swipable/flutter_swipable.dart';


class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300, width: 200,
          child: Stack(
            children: [
              Swipecard(color: Colors.deepPurple),
              Swipecard(color: Colors.blue),
              Swipecard(color: Colors.green),

            ],
          ),
        ),
      ),
    );
  }
}
class Swipecard extends StatelessWidget {
  final color;

  Swipecard({required this.color});
  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Container(
        color: color,
      ),
    );
  }
}