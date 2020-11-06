import 'package:flutter/material.dart';

class Creature extends StatelessWidget {
  final colour;
  Creature(this.colour) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      height: 20.0,
      color: this.colour,
    );
  }
}
