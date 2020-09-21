import 'package:batterydoctor/authentication/auth_service.dart';
import 'package:flutter/material.dart';

AuthService _authService = AuthService();

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: Column(
            children: [
              Text('Service'),
              RaisedButton(
                onPressed: () {
                  _authService.logout();
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Logout'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
