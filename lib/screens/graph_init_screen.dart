import 'package:flutter/material.dart';
import 'package:graph_manager/managers/graph_manager.dart';
import 'package:graph_manager/model/graph.dart';
import 'package:graph_manager/model/node.dart';
import 'package:graph_manager/screens/check_box.dart';
import 'package:graph_manager/utils/colors.dart';

class GraphInitScreen extends StatefulWidget {
  const GraphInitScreen({super.key});

  @override
  State<GraphInitScreen> createState() => _GraphInitScreenState();
}

class _GraphInitScreenState extends State<GraphInitScreen> {
  late Graph graph = Graph(
    size: 8,
  );

  @override
  void initState() {
    super.initState();
  }

  List<Node> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
                            String.fromCharCode('A'.codeUnitAt(0) + index),
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
                                      value:
                                          node.isLinkedTo(graph.getNode(j)!) ||
                                              i == j,
                                      onChanged: (value) {
                                        setState(() {
                                          if (!value!) {
                                            graph.linkNodes(
                                                node, graph.getNode(j)!);
                                          } else {
                                            graph.unlinkNodes(
                                                node, graph.getNode(j)!);
                                          }
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
            TextButton(
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
              result.length.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
