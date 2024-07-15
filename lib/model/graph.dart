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

  void removeNode(Node node) {
    for (Node nd in nodes) {
      nd.unlinkToNode(node);
    }
    nodes.remove(node);
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

  Graph clone(Graph graph) {
    Graph g = Graph(size: graph.size);
    for (Node n in g.nodes) {
      for (Node nd in graph.nodes) {
        for (Node nd2 in graph.nodes) {
          if (n.name == nd.name && nd.isLinkedTo(nd2)) {
            n.linkToNode(g.nodes
                .where((element) => element.name == nd2.name)
                .toList()
                .first);
          }
        }
      }
    }
    return g;
  }

  @override
  String toString() => 'Graph(nodes: $nodes, size: $size)';
}
