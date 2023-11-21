import 'package:flutter/material.dart';

import 'data/data.dart';
import 'data/draggable_widget.dart';
import 'data/utils.dart';
import 'main.dart';

class DragAndDropExample extends StatefulWidget {
  @override
  //_DragAndDropExampleState createState() => _DragAndDropExampleState();
  _DraggableAdvancedPageState createState() => _DraggableAdvancedPageState();
}

class _DraggableAdvancedPageState extends State<DragAndDropExample> {
  final List<Animal> all = allAnimals;
  final List<Animal> land = [];
  final List<Animal> air = [];

  final double size = 150;

  void removeAll(Animal toRemove) {
    all.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
    land.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
    air.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Drag and Drop"),
      centerTitle: true,
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildTarget(
          context,
          text: 'All',
          animals: all,
          acceptTypes: AnimalType.values,
          onAccept: (data) => setState(() {
            removeAll(data);
            all.add(data);
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildTarget(
              context,
              text: 'Animals',
              animals: land,
              acceptTypes: [AnimalType.land],
              onAccept: (data) => setState(() {
                removeAll(data);
                land.add(data);
              }),
            ),
            buildTarget(
              context,
              text: 'Birds',
              animals: air,
              acceptTypes: [AnimalType.air],
              onAccept: (data) => setState(() {
                removeAll(data);
                air.add(data);
              }),
            ),
          ],
        ),
      ],
    ),
  );

  Widget buildTarget(
      BuildContext context, {
        required String text,
        required List<Animal> animals,
        required List<AnimalType> acceptTypes,
        required DragTargetAccept<Animal> onAccept,
      }) =>
      CircleAvatar(
        radius: size / 2,
        child: DragTarget<Animal>(
          builder: (context, candidateData, rejectedData) => Stack(
            children: [
              ...animals
                  .map((animal) => DraggableWidget(animal: animal, key: null,))
                  .toList(),
              IgnorePointer(child: Center(child: buildText(text))),
            ],
          ),
          onWillAccept: (data) => true,
          onAccept: (data) {
            if (acceptTypes.contains(data.type)) {
              /*Utils.showSnackBar(
                context,
                text: 'This Is Correct 🥳',
                color: Colors.green,
              );*/

            } else {
              /*Utils.showSnackBar(
                context,
                text: 'This Looks Wrong 🤔',
                color: Colors.red,
              );*/
            }

            onAccept(data);
          },
        ),
      );

  Widget buildText(String text) => Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.8),
        blurRadius: 12,
      )
    ]),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _DragAndDropExampleState extends State<DragAndDropExample> {
  List<String> containerAItems = ['Item 1', 'Item 2', 'Item 3'];
  List<String> containerBItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Example'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 200,
            width: 150,
            color: Colors.blue,
            child: DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: containerAItems.length,
                  itemBuilder: (context, index) {
                    return Draggable<String>(
                      data: containerAItems[index],
                      child: ListTile(
                        title: Text(containerAItems[index]),
                      ),
                      feedback: Material(
                        child: ListTile(
                          title: Text(containerAItems[index]),
                          tileColor: Colors.blue[100],
                        ),
                      ),
                      childWhenDragging: Container(),
                    );
                  },
                );
              },
              onWillAccept: (data) => true,
              onAccept: (data) {
                setState(() {
                  containerAItems.remove(data);
                  containerBItems.add(data);
                });
              },
            ),
          ),
          Container(
            height: 200,
            width: 150,
            child: DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: containerBItems.length,
                  itemBuilder: (context, index) {
                    return Draggable<String>(
                      data: containerBItems[index],
                      child: ListTile(
                        title: Text(containerBItems[index]),
                      ),
                      feedback: Material(
                        child: ListTile(
                          title: Text(containerBItems[index]),
                          tileColor: Colors.green[100],
                        ),
                      ),
                      childWhenDragging: Container(),
                    );
                  },
                );
              },
              onWillAccept: (data) => true,
              onAccept: (data) {
                setState(() {
                  containerBItems.remove(data);
                  containerAItems.add(data);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
