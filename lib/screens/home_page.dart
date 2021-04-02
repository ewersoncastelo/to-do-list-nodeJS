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
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedIndex;

  final _toDoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _readData().then(
      (value) => {
        setState(() {
          _toDoList = json.decode(value);
        })
      },
    );
  }

  Future<File> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFilePath();
    return file.writeAsString(data);
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
      _saveData();
    });
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return 1;
        else
          return 0;
      });

      _saveData();
    });

    return null;
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
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                return Material(
                  child: Dismissible(
                    key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Platform.isAndroid
                              ? Icons.delete
                              : CupertinoIcons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    child: CheckboxListTile(
                      onChanged: (completedTask) {
                        setState(() {
                          _toDoList[index]["ok"] = completedTask;
                          _saveData();
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
                    onDismissed: (direction) {
                      setState(() {
                        _lastRemoved = Map.from(_toDoList[index]);
                        _lastRemovedIndex = index;
                        _toDoList.removeAt(index);
                        _saveData();
                      });

                      if (Platform.isAndroid) {
                        final snack = SnackBar(
                          content: Text(
                              "Tarefa \"${_lastRemoved["title"]}\" removida."),
                          action: SnackBarAction(
                            label: "Desfazer?",
                            onPressed: () {
                              setState(() {
                                _toDoList.insert(
                                    _lastRemovedIndex, _lastRemoved);
                                _saveData();
                              });
                            },
                          ),
                          duration: Duration(seconds: 2),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      } else {
                        showCupertinoDialog(
                          context: context,
                          builder: (_) => PlatformAlertDialog(
                            title: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Desfazer',
                                style: TextStyle(color: CupertinoColors.label),
                              ),
                            ),
                            content: Text(
                                "A  Tarefa \"${_lastRemoved["title"]}\" será removida."),
                            actions: <Widget>[
                              PlatformDialogAction(
                                child: Text("Confirmar"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              PlatformDialogAction(
                                child: Text("Desfazer"),
                                onPressed: () {
                                  setState(() {
                                    _toDoList.insert(
                                        _lastRemovedIndex, _lastRemoved);
                                    _saveData();
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
