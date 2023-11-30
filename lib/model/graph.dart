// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:graph_manager/model/node.dart';

class Graph {
  late List<Node> nodes;
  int size;

  Graph({
    required this.size,
  }) {
    nodes = List.generate(
      size,
      (index) => Node.empty(
        name: String.fromCharCode('A'.codeUnitAt(0) + index),
      ),
    );
  }

  void linkNodes(Node node1, Node node2) {
    node1.linkToNode(node2);
    node2.linkToNode(node1);
  }

  void unlinkNodes(Node node1, Node node2) {
    node1.unlinkToNode(node2);
    node2.unlinkToNode(node1);
  }

  Node? getNode(int index) {
    try {
      return nodes[index];
    } catch (e) {
      return null;
    }
  }
}
