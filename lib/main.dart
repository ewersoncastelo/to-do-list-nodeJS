import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [];

  Future<File> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFilePath();
    file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFilePath();

      return file.readAsString();
    } catch (error) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
          child: Form(
            child: Row(
              children: [
                Expanded(
                  child: PlatformTextField(
                    material: (context, platform) => MaterialTextFieldData(
                      decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent[100]),
                      ),
                    ),
                    cupertino: (context, platform) => CupertinoTextFieldData(
                      placeholder: 'Nova Tarefa',
                      placeholderStyle: TextStyle(
                        color: Colors.blueAccent[100],
                      ),
                    ),
                  ),
                ),
                PlatformButton(
                  onPressed: () => print('Adicionar'),
                  child: PlatformText('Adicionar'),
                  material: (context, platform) => MaterialRaisedButtonData(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    elevation: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
