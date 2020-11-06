import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:my_app/BLoC/bloc.dart';

class MyBloc implements Bloc {
  int _numOfCreatures;

  MyBloc(int numOfCreatures) {
    _numOfCreatures = numOfCreatures;
  }
  final _myStreamController = StreamController<List<Color>>();

  // OUTPUT
  Stream<List<Color>> get myStream => _myStreamController.stream;

  // INPUT
  void nextGeneration() {
    List<Color> colourList = List<Color>();

    for (int i = 0; i < _numOfCreatures; i++) {
      colourList.add(Color(Random().nextInt(0xffffffff)));
    }
    _myStreamController.sink.add(colourList);
  }

  @override
  void dispose() {
    _myStreamController.close();
  }
}
