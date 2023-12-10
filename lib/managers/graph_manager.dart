import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';

class GraphManager {
  List<Node> articulationNodes(Graph graph) {
    List<Node> articulationNodes = [];
    int i = 0;
    while (i < graph.nodes.length) {
      Node node = graph.getNode(i)!;
      //! Removing Node From Graph
      for (Node ndd in node.neighbors) {
        ndd.unlinkToNode(node);
      }
      graph.nodes.remove(node);

      int j = 0;
      bool stillAccess = true;
      while (j < graph.nodes.length && stillAccess) {
        Node nd = graph.getNode(j)!;
        stillAccess = doBreadthFirstSearch(graph, nd);
        j++;
      }
      if (!stillAccess) {
        articulationNodes.add(node);
      }

      for (Node nddd in node.neighbors) {
        nddd.linkToNode(node);
      }
      graph.nodes.insert(i, node);

      i++;
    }
    return articulationNodes;
  }

  static bool doBreadthFirstSearch(Graph graph, Node node) {
    List<Node> visited = [];
    List<Node> toBeVisited = [node];
    while (toBeVisited.isNotEmpty) {
      Node nd = toBeVisited.first;
      toBeVisited.removeAt(0);
      visited.add(nd);
      for (Node n in nd.neighbors) {
        if (toBeVisited.every((item) => item.name != n.name) &&
            visited.every((it) => it.name != n.name)) {
          toBeVisited.add(n);
        }
      }
    }
    return graph.nodes.length == visited.length;
  }
}
