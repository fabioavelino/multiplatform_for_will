import 'package:flutter/material.dart';
import './state_container.dart';

class AddUserScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> firstNameKey =
      new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> lastNameKey =
      new GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> emailKey =
      new GlobalKey<FormFieldState<String>>();

  final User user;

  const AddUserScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    double width = MediaQuery.of(context).size.width > 600
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Form(
        key: formKey,
        autovalidate: false,
        child: new Column(
          children: [
            Container(
                width: width,
                child: TextFormField(
                  key: firstNameKey,
                  style: Theme.of(context).textTheme.headline,
                  decoration: new InputDecoration(
                    hintText: 'First Name',
                  ),
                )),
            Container(
                width: width,
                child: TextFormField(
                  key: lastNameKey,
                  style: Theme.of(context).textTheme.headline,
                  decoration: new InputDecoration(
                    hintText: 'Last Name',
                  ),
                )),
            Container(
                width: width,
                child: TextFormField(
                  key: emailKey,
                  style: Theme.of(context).textTheme.headline,
                  decoration: new InputDecoration(
                    hintText: 'Email Address',
                  ),
                )),
            RaisedButton(
                child: Text("Add"),
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    var firstName = firstNameKey.currentState.value;
                    var lastName = lastNameKey.currentState.value;
                    var email = emailKey.currentState.value;

                    if (firstName == '') {
                      firstName = null;
                    }
                    if (lastName == '') {
                      lastName = null;
                    }
                    if (email == '') {
                      email = null;
                    }

                    container.addUserInfo(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                    );

                    if (MediaQuery.of(context).size.width <= 600) {
                      Navigator.pop(context);
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
