import 'package:graph_manager/screens/graph_init_screen.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setWindowSize(const Size(800, 1280));
  runApp(
    const GraphManagerApp(),
  );
}

class GraphManagerApp extends StatelessWidget {
  const GraphManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const GraphInitScreen(),
    );
  }
}
