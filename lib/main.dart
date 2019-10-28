import 'package:flutter/material.dart';
import './form_page.dart';
import './state_container.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

void main() {
  _setTargetPlatformForDesktop();
  runApp(new StateContainer(child: new TodoApp(), users: new List<User>()));
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Some Todos',
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isLargeScreen = false;
  List<User> users;

  Widget get _usersInfo {
    return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Center(
                    child: Text(
                        '${users[index].firstName} ${users[index].lastName}, ${users[index].email}')),
              );
            }));
  }

  Widget get _welcomeMessage {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text('Please add users informations'),
        ],
      ),
    );
  }

  void _addUser(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new Scaffold(
              appBar: new AppBar(
                title: new Text('Edit User Info'),
              ),
              body: new AddUserScreen());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    users = container.users;
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    debugPrint('isLargeScreen: ${isLargeScreen}');
    var body = users.length > 0 ? _usersInfo : _welcomeMessage;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Contacts'),
      ),
      body: isLargeScreen
          ? Row(children: <Widget>[_usersInfo, new AddUserScreen()])
          : body,
      floatingActionButton: isLargeScreen
          ? null
          : new FloatingActionButton(
              onPressed: () => _addUser(context),
              child: new Icon(Icons.add),
            ),
    );
  }
}
