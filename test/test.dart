import 'package:graph_manager/managers/graph_manager.dart';
import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';

void main() {
  Graph graph = Graph(
    size: 5,
  );
  graph.linkNodes(graph.getNode(0)!, graph.getNode(1)!);
  graph.linkNodes(graph.getNode(0)!, graph.getNode(2)!);
  graph.linkNodes(graph.getNode(0)!, graph.getNode(3)!);
  graph.linkNodes(graph.getNode(1)!, graph.getNode(2)!);
  graph.linkNodes(graph.getNode(3)!, graph.getNode(4)!);

  GraphManager graphManager = GraphManager();

  List<Node> result = graphManager.articulationNodes(graph);
  print(result.length);
}
