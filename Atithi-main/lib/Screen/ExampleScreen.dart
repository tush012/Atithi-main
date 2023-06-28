import 'package:flutter/material.dart';


class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  Offset draggableTextPosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: draggableTextPosition.dx,
            top: draggableTextPosition.dy,
            child: Draggable(
              child: Text('Drag Me!'),
              feedback: Text('Drag Me!'),
              childWhenDragging: Container(),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  draggableTextPosition = offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
