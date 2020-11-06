import 'package:flutter/material.dart';
import 'package:my_app/BLoC/my_bloc.dart';

import 'creature.dart';

class EvolutionPage extends StatefulWidget {
  final MyBloc myBloc = MyBloc(100);

  final List<Widget> rows = List<Widget>();

  int numOfRows = 10;
  int numOfCreatures = 100;

  @override
  _EvolutionPageState createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  void buttonHandler() {
    widget.myBloc.nextGeneration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: StreamBuilder<List<Color>>(
          stream: widget.myBloc.myStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: createCreatureRows(
                        widget.numOfRows, widget.numOfCreatures, snapshot.data),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: Container(
                      width: 120.0,
                      height: 50.0,
                      color: Colors.white,
                      child: FlatButton(
                        onPressed: buttonHandler,
                        child: Text(
                          "Start/Stop",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return Stack(
              children: [
                Center(
                  child: Text(
                    "No data",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: Container(
                    width: 120.0,
                    height: 50.0,
                    color: Colors.white,
                    child: FlatButton(
                      onPressed: buttonHandler,
                      child: Text(
                        "Start/Stop",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    widget.myBloc.dispose();
    super.dispose();
  }
}

List<Row> createCreatureRows(
    int numOfRows, int numOfCreatures, List<Color> colourList) {
  final List<Creature> creatures = List<Creature>();
  final List<Row> rows = List<Row>();

  for (int i = 0; i < numOfCreatures; i++) {
    creatures.add(Creature(colourList[i]));
  }

  List<List<Creature>> listsForRows = List<List<Creature>>();

  for (int i = 0; i < creatures.length; i++) {
    if (i % numOfRows > listsForRows.length - 1) {
      listsForRows.add(List<Creature>());
    }
    listsForRows[i % numOfRows].add(creatures[i]);
  }

  for (int i = 0; i < listsForRows.length; i++) {
    rows.add(Row(
      children: listsForRows[i],
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    ));
  }
  return rows;
}
