import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _index = 0;

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
        return MaterialScaffoldData(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("button tapped");
            },
            backgroundColor: Colors.purple,
            child: Icon(Icons.add),
            elevation: 6,
            mini: true,
          ),
        );
      },
      body: Center(
        child: Text("Hello"),
      ),
      bottomNavBar: PlatformNavBar(
        currentIndex: _index,
        itemChanged: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Colors.black38),
            title: Text('Screen 1'),
            activeIcon: Icon(Icons.business, color: Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Colors.black38),
            title: Text('Screen 2'),
            activeIcon: Icon(Icons.business, color: Colors.black),
          ),
        ],
        material: (context, platform) {
          return MaterialNavBarData(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
          );
        },
      ),
    );
  }
}
