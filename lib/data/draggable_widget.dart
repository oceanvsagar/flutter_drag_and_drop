import 'package:flutter/material.dart';

import 'data.dart';

class DraggableWidget extends StatelessWidget {
  final Animal animal;

  const DraggableWidget({super.key,
    required this.animal,
  });

  static double size = 150;

  @override
  Widget build(BuildContext context) => Draggable<Animal>(
        data: animal,
        feedback: buildImage(),
        child: buildImage(),
        childWhenDragging: Container(height: size),
      );

  Widget buildImage() => Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Image.asset(animal.imageUrl),
      );
}
