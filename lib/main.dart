import 'dart:io';

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
    return Platform.isAndroid
        ? MaterialApp(
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
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              barBackgroundColor: Colors.blue[900],
              textTheme: CupertinoTextThemeData(
                navTitleTextStyle: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              brightness: Brightness.light,
            ),
            home: CupertinoPageScaffold(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return <Widget>[
                    CupertinoSliverNavigationBar(
                      largeTitle: Text(
                        "Lista de Tarefas",
                        style: TextStyle(color: Colors.white),
                      ),
                      brightness: Brightness.dark,
                    ),
                  ];
                },
                body: HomePage(),
              ),
            ),
          );
  }
}
