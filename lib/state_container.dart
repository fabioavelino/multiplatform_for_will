import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class User {
  String firstName;
  String lastName;
  String email;

  User(this.firstName, this.lastName, this.email);
}

class StateContainer extends StatefulWidget {
  final Widget child;
  final List<User> users;

  StateContainer({
    @required this.child,
    this.users,
  });

  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => new StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  List<User> users = new List<User>();

  void addUserInfo({firstName, lastName, email}) {
    User user = new User(firstName, lastName, email);
    users.add(user);

    setState(() {
      users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
