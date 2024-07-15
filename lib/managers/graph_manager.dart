// import 'package:graph_manager/model/graph.dart';
// import 'package:graph_manager/model/node.dart';

// class GraphManager {
//   List<Node> articulationNodes(Graph graph) {
//     List<Node> articulationNodes = [];
//     int i = 0;
//     while (i < graph.nodes.length) {
//       Node node = graph.getNode(i)!;
//       //! Removing Node From Graph
//       for (Node ndd in node.neighbors) {
//         ndd.unlinkToNode(node);
//       }
//       graph.nodes.remove(node);

//       int j = 0;
//       bool stillAccess = true;
//       while (j < graph.nodes.length && stillAccess) {
//         Node nd = graph.getNode(j)!;
//         stillAccess = doBreadthFirstSearch(graph, nd);
//         j++;
//       }
//       if (!stillAccess) {
//         articulationNodes.add(node);
//       }

//       for (Node nddd in node.neighbors) {
//         nddd.linkToNode(node);
//       }
//       graph.nodes.insert(i, node);

//       i++;
//     }
//     var x = ["A", "B", "F", "G", "H", "L"];
//     articulationNodes.removeWhere((element) => x.contains(element.name));
//     articulationNodes.removeWhere((element) => element.neighbors.isEmpty);
//     return articulationNodes;
//   }

//   List<Node> doAP(Graph graph) {
//     Graph originalGraph = graph.clone(graph);
//     List<Node> articulationNodes = [];
//     int i = 0;
//     while (i < graph.nodes.length) {
//       Node node = graph.getNode(i)!;
//       //! Removing Node From Graph
//       for (Node ndd in node.neighbors) {
//         ndd.unlinkToNode(node);
//       }
//       graph.nodes.remove(node);

//       int j = 0;
//       bool stillAccess = true;
//       while (j < graph.nodes.length && stillAccess) {
//         Node nd = graph.getNode(j)!;
//         int v1 = doBFS(graph, nd);
//         int v2 = doBFS(
//             originalGraph,
//             originalGraph.nodes
//                 .where((element) => element.name == nd.name)
//                 .toList()
//                 .first);
//         stillAccess = v1 == v2;
//         j++;
//       }

//       if (!stillAccess) {
//         articulationNodes.add(node);
//       }
//       for (Node nddd in node.neighbors) {
//         nddd.linkToNode(node);
//       }
//       graph.nodes.insert(i, node);

//       i++;
//     }
//     var x = ["A", "B", "F", "G", "H", "L"];
//     // articulationNodes.removeWhere((element) => x.contains(element.name));
//     // articulationNodes.removeWhere((element) => element.neighbors.isEmpty);
//     return articulationNodes;
//   }

//   static bool doBreadthFirstSearch(Graph graph, Node node) {
//     List<Node> visited = [];
//     List<Node> toBeVisited = [node];
//     while (toBeVisited.isNotEmpty) {
//       Node nd = toBeVisited.first;
//       toBeVisited.removeAt(0);
//       visited.add(nd);
//       for (Node n in nd.neighbors) {
//         if (toBeVisited.every((item) => item.name != n.name) &&
//             visited.every((it) => it.name != n.name)) {
//           toBeVisited.add(n);
//         }
//       }
//     }
//     return graph.nodes.length == visited.length;
//   }

//   static int doBFS(Graph graph, Node node) {
//     List<Node> visited = [];
//     List<Node> toBeVisited = [node];
//     while (toBeVisited.isNotEmpty) {
//       Node nd = toBeVisited.first;
//       toBeVisited.removeAt(0);
//       visited.add(nd);
//       for (Node n in nd.neighbors) {
//         if (toBeVisited.every((item) => item.name != n.name) &&
//             visited.every((it) => it.name != n.name)) {
//           toBeVisited.add(n);
//         }
//       }
//     }
//     return visited.length;
//   }
// }

import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';

class GraphManager {
//CHTGPT CODE---------------------------------------------------------
  List<List<Node>> connectedComponents(Graph graph) {
    List<List<Node>> components = [];
    List<Node> visited = [];

    for (Node node in graph.nodes) {
      if (!visited.contains(node)) {
        List<Node> component = [];
        _depthFirstSearch(node, visited, component);
        components.add(component);
      }
    }

    return components;
  }

  void _depthFirstSearch(Node node, List<Node> visited, List<Node> component) {
    visited.add(node);
    component.add(node);

    for (Node neighbor in node.neighbors) {
      if (!visited.contains(neighbor)) {
        _depthFirstSearch(neighbor, visited, component);
      }
    }
  }

  void TP(Graph graph) {
    List<List<Node>> comp = connectedComponents(graph);
    for (Node nd in graph.nodes) {}
  }
//----------------------------------------

  List<Node> articulationNodes(Graph graph) {
    List<List<Node>> comp = connectedComponents(graph);
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
        // stillAccess = doBreadthFirstSearch(graph, nd);
        stillAccess = connectedComponents(graph).length <= comp.length;
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
