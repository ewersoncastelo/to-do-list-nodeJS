import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List _listTasks = [
    "Go to Shopping",
    "Put in bed the book",
    "Put in bed the book",
    "Put in bed the book"
  ];

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
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _listTasks[index],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
        cupertino: (context, platform) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _listTasks.length,
                  itemBuilder: (context, index) {
                    return ListBody(
                      children: [
                        Text(_listTasks[index]),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
