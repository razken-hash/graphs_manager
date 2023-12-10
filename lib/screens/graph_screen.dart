// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graph_manager/managers/graph_manager.dart';

import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';
import 'package:graph_manager/utils/colors.dart';

class GraphScreen extends StatelessWidget {
  Graph graph;
  List<Node> articulationPoints;
  GraphScreen({
    super.key,
    required this.graph,
    required this.articulationPoints,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        size: const Size(300, 300),
        painter:
            GraphPaint(graph: graph, articulationPoints: articulationPoints),
      ),
    );
  }
}

class GraphPaint extends CustomPainter {
  Graph graph;
  List<Node> articulationPoints;

  GraphPaint({
    required this.graph,
    required this.articulationPoints,
  });

  List<Offset> offsets = [];

  generateOffsets(Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    int i = 0;
    double thetaStep = 2 * pi / graph.size;
    double radius = size.height / 2;
    while (i < graph.nodes.length) {
      double theta = i * thetaStep;
      double x = center.dx + radius * cos(theta);
      double y = center.dy - radius * sin(theta);
      offsets.add(Offset(x, y));
      i++;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    generateOffsets(size);

    Paint roadsPainter = Paint()
      ..color = mainColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Paint nodesPainter = Paint()
      ..color = mainColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    int i = 0;
    while (i < graph.nodes.length) {
      Node node = graph.getNode(i)!;
      int j = 0;
      while (j < node.neighbors.length) {
        canvas.drawLine(
          offsets[i],
          offsets[graph.nodes.indexOf(node.neighbors[j])],
          roadsPainter,
        );
        j++;
      }
      i++;
    }
    i = 0;
    while (i < graph.nodes.length) {
      Node node = graph.getNode(i)!;
      if (articulationPoints.contains(node)) {
        nodesPainter.color = red;
      } else {
        nodesPainter.color = mainColor;
      }
      canvas.drawCircle(offsets[i], 15, nodesPainter);
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
