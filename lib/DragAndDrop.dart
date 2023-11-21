import 'package:flutter/material.dart';

class DragAndDrop extends StatefulWidget {
  static String id = "DragAndDrop";

  @override
  _DragAndDropState createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  Color caughtColor = Colors.white;
  bool _isDropped = false;
  bool _isDragging = false;

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
        body: SafeArea(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Draggable(
            data: Colors.orangeAccent,
            onDragStarted: () {
              _setIsDragging();
            },
            onDraggableCanceled: (_, __) {
              _resetIsDragging();
            },
            feedback: Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 10),
              //color: Colors.orangeAccent.withOpacity(0.5),
              child: Center(child: Image.asset('assets/I-2019Mathematics.png')),
            ),
            child: Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 10),
              //color: Colors.orangeAccent,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, //color of border
                    width: 2, //width of border
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Image.asset('assets/I-2019Mathematics.png'),
            ),
          ),
          DragTarget(
            onWillAccept: (data) {
              return true;
            },
            onAccept: (Color color) {
              caughtColor = color;
              //debugPrint('hi $color');
              setState(() {
                _isDropped = true;
              });
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Center(
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 20),
                  //color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, //color of border
                        width: 2, //width of border
                      ),
                      color:
                          accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0)),
                  //alignment: Alignment.center,
                  child: Center(
                    child: _isDropped
                        ? (caughtColor == Colors.green
                            ? Image.asset('assets/I-2019Hindi.png')
                            : caughtColor == Colors.orangeAccent
                                ? Image.asset('assets/I-2019Mathematics.png')
                                : null)
                        : null,
                  ),
                ),
              );
            },
          ),
          /*DragTarget(
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (Color color) {
                  caughtColor = color;
                  //debugPrint('hi $color');
                  setState(() {
                    _isDropped = true;
                  });
                }, builder: (
                  BuildContext context, List < dynamic > accepted, List < dynamic > rejected, ) {
                return Center(
                    child: Draggable(
                      data: Colors.orangeAccent,
                      onDragStarted: () {
                        _setIsDragging();
                      },
                      onDraggableCanceled: (_, __) {
                        _resetIsDragging();
                      },
                      feedback: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        //color: Colors.orangeAccent.withOpacity(0.5),
                        child: Center(
                            child: Image.asset('assets/I-2019Mathematics.png')
                        ),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        //color: Colors.orangeAccent,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 2, //width of border
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                        ),
                        //child: Image.asset('assets/I-2019Mathematics.png'),
                        child: _isDropped ? (caughtColor == Colors.orangeAccent ? Image.asset('assets/I-2019Hindi.png') : caughtColor == Colors.orangeAccent ? Image.asset('assets/I-2019Mathematics.png') : null ): null,
                      ),
                    )
                );
              },
              ),
              DragTarget(
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (Color color) {
                  caughtColor = color;
                  //debugPrint('hi $color');
                  setState(() {
                    _isDropped = true;
                  });
                }, builder: (
                BuildContext context, List < dynamic > accepted, List < dynamic > rejected, ) {
                  return Center(
                    child: Draggable(
                      data: Colors.green,
                      onDragStarted: () {
                        _setIsDragging();
                      },
                      onDraggableCanceled: (_, __) {
                        _resetIsDragging();
                      },
                      feedback: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        //color: Colors.orangeAccent.withOpacity(0.5),
                        child: Center(
                            child: Image.asset('assets/I-2019Mathematics.png')
                        ),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 20),
                        //color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, //color of border
                              width: 2, //width of border
                            ),
                            color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        //alignment: Alignment.center,
                        child: Center(
                          child: _isDropped ? (caughtColor == Colors.green ? Image.asset('assets/I-2019Hindi.png') : caughtColor == Colors.orangeAccent ? Image.asset('assets/I-2019Mathematics.png') : null ): null,
                        ),
                      ),
                    )
                  );
                },
              ),*/
        ],
      ),
    ));
  }
}
