import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';

class GraphManager {
  static Graph graph = Graph(
    size: 8,
  );
  List<Node> articulationNodes(Graph graph) {
    List<Node> articulationNodes = [];
    int i = 0;
    while (i < graph.nodes.length) {
      Node node = graph.getNode(i)!;
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
      graph.nodes.insert(i, node);
      i++;
    }
    return articulationNodes;
  }

  bool doBreadthFirstSearch(Graph graph, Node node) {
    return true;
  }
}
