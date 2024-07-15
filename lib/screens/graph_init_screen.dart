import 'package:flutter/material.dart';
import 'package:graph_manager/managers/graph_manager.dart';
import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';
import 'package:graph_manager/screens/check_box.dart';
import 'package:graph_manager/screens/graph_screen.dart';
import 'package:graph_manager/utils/colors.dart';

class GraphInitScreen extends StatefulWidget {
  const GraphInitScreen({super.key});

  @override
  State<GraphInitScreen> createState() => _GraphInitScreenState();
}

class _GraphInitScreenState extends State<GraphInitScreen> {
  late Graph graph = Graph(
    size: 5,
  );
  late List<Node> articulationPoints;
  @override
  void initState() {
    setState(() {
      articulationPoints = graph.nodes;
    });
    super.initState();
  }

  final GraphManager _graphManager = GraphManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                graph.size--;
                graph.removeNode(graph.nodes.last);
                articulationPoints = _graphManager.articulationNodes(graph);
              });
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                graph.size++;
                graph.nodes.add(
                  Node.empty(
                    name:
                        String.fromCharCode('A'.codeUnitAt(0) + graph.size - 1),
                  ),
                );
                articulationPoints = _graphManager.articulationNodes(graph);
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text(
                "GRAPHS, ARTICULATION POINTS CHECKER",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: mainColor,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: DataTable(
                        border: TableBorder.all(
                          width: 5.0,
                          color: grey,
                        ),
                        showCheckboxColumn: false,
                        columns: [
                          const DataColumn(
                              label: SizedBox(
                            height: 120,
                            width: 60,
                          )),
                          ...List.generate(
                            graph.size,
                            (index) => DataColumn(
                              label: SizedBox(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(
                                        'A'.codeUnitAt(0) + index),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(graph.size, (i) {
                          Node node = graph.getNode(i)!;
                          return DataRow(
                            cells: [
                              DataCell(
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      node.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ...List.generate(
                                graph.size,
                                (j) => DataCell(
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                      child: i == j
                                          ? null
                                          : GraphCheckBox(
                                              value: node.isLinkedTo(
                                                      graph.getNode(j)!) ||
                                                  i == j,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (!value!) {
                                                    graph.linkNodes(node,
                                                        graph.getNode(j)!);
                                                  } else {
                                                    graph.unlinkNodes(node,
                                                        graph.getNode(j)!);
                                                  }
                                                  articulationPoints =
                                                      _graphManager
                                                          .articulationNodes(
                                                              graph);
                                                });
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GraphScreen(
                            graph: graph,
                            articulationPoints: articulationPoints,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 10,
                            shadowColor: const Color(0xFFFF8C3B),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  shadowColor: Colors.black,
                                  backgroundColor: white,
                                  padding: const EdgeInsets.all(30)),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Points d'articulations: ${articulationPoints.isEmpty ? "/" : ""}",
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ...articulationPoints.map(
                                    (e) => Text(
                                      "${e.name}${e.name == articulationPoints.last.name ? "" : ", "}",
                                      style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(),
            /*TextButton(
              onPressed: () {
                GraphManager graphManager = GraphManager();
                setState(() {
                  result = graphManager.articulationNodes(graph);
                });
              },
              child: const Text(
                'Calc',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: mainColor,
                ),
              ),
            ),
            Text(
              result.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: mainColor,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
