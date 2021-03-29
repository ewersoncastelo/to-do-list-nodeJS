import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [];

  final _toDoController = TextEditingController();

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

  void _addTodo() {
    setState(() {
      Map<String, dynamic> newTodoTask = Map();
      newTodoTask["title"] = _toDoController.text;
      _toDoController.text = "";
      newTodoTask["ok"] = false;
      _toDoList.add(newTodoTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
          child: Column(
            children: [
              Row(
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
                      controller: _toDoController,
                    ),
                  ),
                  PlatformButton(
                    onPressed: _addTodo,
                    child: PlatformText('Adicionar'),
                    material: (context, platform) => MaterialRaisedButtonData(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      elevation: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: _toDoList.length,
            itemBuilder: (context, index) {
              return Material(
                child: CheckboxListTile(
                  onChanged: (completedTask) {
                    setState(() {
                      _toDoList[index]["ok"] = completedTask;
                    });
                  },
                  title: Text(_toDoList[index]["title"]),
                  value: _toDoList[index]["ok"],
                  secondary: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Platform.isAndroid
                        ? Icon(
                            _toDoList[index]["ok"]
                                ? Icons.check
                                : Icons.access_alarm_outlined,
                          )
                        : Icon(
                            _toDoList[index]["ok"]
                                ? CupertinoIcons.checkmark_alt
                                : CupertinoIcons.alarm,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
