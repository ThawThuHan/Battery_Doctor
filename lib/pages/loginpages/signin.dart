import 'package:batterydoctor/authentication/auth_service.dart';
import 'package:batterydoctor/pages/loginpages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _isAuth = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  AuthService _authService = AuthService();

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black),
      filled: true,
      fillColor: Theme.of(context).primaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  authFailed() {
    return Text(
      'Wrong Email or Password!',
      style: TextStyle(
        color: Colors.red,
      ),
    );
  }

  login() async {
    if (_formKey.currentState.validate()) {
      String email = _email.text.trim();
      String password = _password.text.trim();
      dynamic user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        print(user);
      } else {
        setState(() {
          _isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Battery Doctor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontFamily: 'Lobster',
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please fill valid Email';
                    } else {
                      return null;
                    }
                  },
                  controller: _email,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
//                    labelText: 'Email',
                      hintText: 'Enter Your Email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.length < 6) {
                      return 'Please fill at least 6 character';
                    } else {
                      return null;
                    }
                  },
                  controller: _password,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  decoration: InputDecoration(
//                    labelText: 'Password',
                      hintText: 'Enter Your Password',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 100.0, vertical: 16.0),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    height: 42.0,
                    minWidth: 200.0,
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              _isAuth ? authFailed() : Text(''),
              SizedBox(
                height: 70.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Register();
                  }));
                },
                child: new Container(
                  height: 50.0,
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white, width: 1.0),
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: new Center(
                    child: new Text(
                      'No Account? Register Now!',
                      style: new TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
