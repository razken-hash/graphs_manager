class Node {
  final String name;
  List<Node> neighbors = [];

  Node? getNeighbor(int index) {
    try {
      return neighbors[index];
    } catch (e) {
      return null;
    }
  }

  void linkToNode(Node node) {
    neighbors.add(node);
  }

  void unlinkToNode(Node node) {
    neighbors.remove(node);
  }

  bool isLinkedTo(Node node) {
    return neighbors.any((neighbor) => neighbor.name == node.name);
  }

  Node({
    required this.name,
    required this.neighbors,
  });

  static Node empty({
    required String name,
  }) {
    return Node(name: name, neighbors: []);
  }

  @override
  String toString() => 'Node(name: $name, neighbors: $neighbors)';
}
