import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todolist/screens/home_page.dart';

void main() {
  runApp(
    TodoList(),
  );
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tarefas"),
          centerTitle: false,
          brightness: Brightness.dark,
        ),
        body: HomePage(),
      ),
    );
  }
}
