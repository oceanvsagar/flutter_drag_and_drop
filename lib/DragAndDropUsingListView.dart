import 'package:flutter/material.dart';

class DragAndDropUsingListView extends StatefulWidget {
  static String id = "DragAndDropUsingListView";

  @override
  _DragAndDropUsingListViewState createState() =>
      _DragAndDropUsingListViewState();
}

class _DragAndDropUsingListViewState extends State<DragAndDropUsingListView> {
  late List<AnimalImages> animalImages;
  Color caughtColor = Colors.white;
  bool _isDropped = false;
  late int draggedIndexValue;
  late int droppedIndexValue;

  @override
  void initState() {
    animalImages = <AnimalImages>[];

    animalImages.add(AnimalImages("1", "Tiger", "assets/animal1.png"));
    animalImages.add(AnimalImages("2", "bird", "assets/bird1.png"));
    animalImages.add(AnimalImages("3", "Parrot", "assets/bird2.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Drag And Drop"),
        ),
        body: SafeArea(
            child: Container(
          color: const Color(0xffE4F1FB),
          child: _bindDataToListView(),
        )));
  }

  Widget _bindDataToListView() {
    return animalImages.isNotEmpty
        ? ListView.builder(
            itemCount: animalImages?.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: DragTarget(
                  onWillAccept: (data) {
                    //debugPrint('onWillAccept value $index');
                    return true;
                  },
                  onAccept: (int data) {
                    //caughtColor = color;
                    _isDropped = true;
                    droppedIndexValue = index;
                    debugPrint('onAccept index value $index $_isDropped');
                    _editanimalImagesData(droppedIndexValue, draggedIndexValue);
                  },
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Center(
                        child: Draggable(
                      data: index,
                      onDragStarted: () {
                        //_setIsDragging();
                        draggedIndexValue = index;
                        //debugPrint('onDragStarted index value $index');
                      },
                      onDraggableCanceled: (_, __) {
                        //debugPrint('onDraggableCanceled index value $index');
                      },
                      onDragCompleted: () {
                        //debugPrint('onDragCompleted index value $index');
                        //draggedIndexValue = index;
                      },
                      feedback: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        //color: Colors.orangeAccent.withOpacity(0.5),
                        child: Center(
                            child: Image.asset(animalImages[index].imageUrl!)),
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
                          color: accepted.isEmpty
                              ? caughtColor
                              : Colors.grey.shade200,
                        ),
                        child: Image.asset(animalImages[index].imageUrl!),
                      ),
                    ));
                  },
                ),
              );
            })
        : const Center(
            child: Text(
              'No data found',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 16,
              ),
            ),
          );
  }

  _editanimalImagesData(droppedIndexValue, draggedIndexValue) {
    debugPrint(
        'droppedIndexValue: $droppedIndexValue \n draggedIndexValue: $draggedIndexValue');
    String? draggedImageUrl = animalImages[draggedIndexValue].imageUrl;
    String? droppedImageUrl = animalImages[droppedIndexValue].imageUrl;
    animalImages[draggedIndexValue].imageUrl = droppedImageUrl;
    animalImages[droppedIndexValue].imageUrl = draggedImageUrl;
    setState(() {});
  }
}

class AnimalImages {
  String? id = "";
  String? name = "";
  String? imageUrl = "";

  AnimalImages(this.id, this.name, this.imageUrl);

  AnimalImages.fromMap(Map<String, dynamic> map)
      : id = map["id"] ?? "",
        name = map["name"] ?? "",
        imageUrl = map["imageUrl"] ?? "";
}
