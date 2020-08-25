import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:path_provider/path_provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List _listTasks = [];
  TextEditingController _controllerTaskTextEditing = TextEditingController();

  Future<File> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  _saveFile() async {
    // Path File
    var file = await _getFilePath();

    var data = json.encode(_listTasks);
    file.writeAsString(data);
  }

  _loadFile() async {
    try {
      final file = await _getFilePath();

      return file.readAsString();
    } catch (error) {
      error.toString();
      return null;
    }
  }

  _saveTaskUser() {
    String textTaskUser = _controllerTaskTextEditing.text;

    // create data
    Map<String, dynamic> task = Map();
    task["title"] = textTaskUser;
    task["complete"] = false;

    setState(() {
      _listTasks.add(task);
    });

    _saveFile();

    _controllerTaskTextEditing.text = "";
  }

  Widget createListItemAndroid(context, index) {
    final item = _listTasks[index];

    return Dismissible(
      key: Key(item['title']),
      child: CheckboxListTile(
        title: Text(item['title']),
        value: item['complete'],
        onChanged: (value) {
          setState(() {
            item['complete'] = value;
          });

          _saveFile();
        },
      ),
      // direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          print("Select edit");
        }

        if (direction == DismissDirection.endToStart) {
          print("Delete object");
        }

        setState(() {
          _listTasks.removeAt(index);
          _saveFile();
        });
      },
      background: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget createListItemIOS(context, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_listTasks[index]['title']),
        CupertinoSwitch(
          value: _listTasks[index]['complete'],
          onChanged: (value) {
            setState(() {
              _listTasks[index]['complete'] = value;
            });

            _saveFile();
          },
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _loadFile().then((data) {
      setState(() {
        _listTasks = json.decode(data);
        print(_listTasks.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          "To Do List",
        ),
        material: (context, platform) {
          return MaterialAppBarData(
            backgroundColor: Colors.deepPurpleAccent,
          );
        },
        cupertino: (context, platform) {
          return CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
            trailing: PlatformButton(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                CupertinoIcons.add,
                color: CupertinoColors.inactiveGray,
              ),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => PlatformAlertDialog(
                    title: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Add Some Task',
                        style: TextStyle(color: CupertinoColors.label),
                      ),
                    ),
                    content: PlatformTextField(
                      cupertino: (context, platform) {
                        return CupertinoTextFieldData(
                          placeholder: "Type yout task",
                        );
                      },
                      onChanged: (text) {},
                      controller: _controllerTaskTextEditing,
                    ),
                    actions: <Widget>[
                      PlatformDialogAction(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      PlatformDialogAction(
                        child: Text("Save"),
                        onPressed: () {
                          // save data
                          _saveTaskUser();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      material: (context, platform) {
        return MaterialScaffoldData(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showPlatformDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                  title: Text('Alert'),
                  content: TextField(
                    decoration: InputDecoration(labelText: "Type your task"),
                    onChanged: (text) {},
                    controller: _controllerTaskTextEditing,
                  ),
                  actions: <Widget>[
                    PlatformDialogAction(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    PlatformDialogAction(
                      child: Text("Save"),
                      onPressed: () {
                        // save data
                        _saveTaskUser();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.deepPurple,
            icon: Icon(Icons.add),
            label: Text("New Task"),
            elevation: 6,
          ),
        );
      },
      body: PlatformWidget(
        material: (context, platform) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _listTasks.length,
                  itemBuilder: createListItemAndroid,
                ),
              )
            ],
          );
        },
        cupertino: (context, platform) {
          return SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _listTasks.length,
              itemBuilder: createListItemIOS,
            ),
          );
        },
      ),
    );
  }
}
