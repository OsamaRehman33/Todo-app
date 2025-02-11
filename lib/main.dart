import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider.dart';
import 'package:todo_app/todo_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => TodoProvider(),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TodoScreen());
  }
}
