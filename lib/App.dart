import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          "To Do List",
        ),
        cupertino: (context, platform) {
          return CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
            trailing: PlatformButton(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                CupertinoIcons.info,
                color: CupertinoColors.inactiveGray,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  CupertinoPageRoute(builder: null),
                );
              },
            ),
          );
        },
      ),
      material: (context, platform) {
        return MaterialScaffoldData();
      },
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
