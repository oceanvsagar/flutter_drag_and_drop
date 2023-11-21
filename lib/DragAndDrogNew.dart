

import 'dart:developer';

import 'package:flutter/material.dart';

class DragAndDropNew extends StatefulWidget{
  static String id = "DragAndDrop";

  @override
  //_DragAndDropNewState createState() => _DragAndDropNewState();
  _MyHomePageState createState() => _MyHomePageState();

}

class _DragAndDropNewState extends State<DragAndDropNew>{
  Color caughtColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: < Widget > [
              // Draggable Widget
              Draggable(
                  data: Colors.orangeAccent,
                  // calling onDraggableCanceled property

                  onDraggableCanceled: (velocity, offset) {},
                  feedback: Container(
                    width: 150,
                    height: 150,
                    color: Colors.orangeAccent.withOpacity(0.5),
                    child: const Center(
                      child: Text(
                        'Box...',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.orangeAccent,
                    child: const Center(
                      child: Text('box'),
                    ),
                  )
              ),

              // building Drag Target Widget
              DragTarget(
                  onAccept: (Color color) {
                    caughtColor = color;
                  }, builder: (
                  BuildContext context,
                  List < dynamic > accepted,
                  List < dynamic > rejected,
                  ) {
                return Container(
                  width: 200,
                  height: 200,
                  color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                  child: const Center(
                    child: Text('Drag here'),
                  ),
                );
              }
              )
            ],
          ),
        ));
  }
}

class _MyHomePageState extends State<DragAndDropNew> {
  int _indexOfDroppedItem = 0;
  bool _isDragging = false;

  void _acceptDraggedItem(int index) {
    setState(() {
      _indexOfDroppedItem = index;
    });
  }

  void _setIsDragging() {
    setState(() {
      _isDragging = true;
    });
  }

  void _resetIsDragging() {
    setState(() {
      _isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag And Drop"),
      ),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          primary: false,
          crossAxisCount: 2,
          children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.all(44.0),
              child: index == _indexOfDroppedItem
                  ? Draggable<int>(
                data: index,
                childWhenDragging: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(20))),
                ),
                onDragStarted: () {
                  _setIsDragging();
                },
                onDraggableCanceled: (_, __) {
                  _resetIsDragging();
                },
                onDragCompleted: () {
                  _resetIsDragging();
                },
                feedback: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      BorderRadius.all(Radius.circular(20))),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                ),
              )
                  : DragTarget<int>(
                builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                    ) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(
                        _isDragging ? const Radius.circular(20) : const Radius.circular(10),
                      ),
                      color: _indexOfDroppedItem == index && !_isDragging
                          ? Colors.green // set the color of the container to green
                          : Colors.white, // set the color of the container to white
                    ),
                  );
                },
                onAccept: (int data) {
                  _acceptDraggedItem(index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}