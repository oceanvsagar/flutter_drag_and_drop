import 'package:flutter/material.dart';

import 'DragAndDrogNew.dart';
import 'DragAndDrop.dart';
import 'DragAndDropScreen.dart';
import 'DragAndDropUsingListView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DragAndDrop(), // Drag and Drop from one container to another container. // Single image
      //home: DragAndDropUsingListView(), //Drag and Drop from one container to another container. // multiple images
      //home: DragAndDropNew(), // Drag and drop color container
      //home: DragAndDropExample(), // Drag and drop from source to destination and reversing it
    );
  }
}
