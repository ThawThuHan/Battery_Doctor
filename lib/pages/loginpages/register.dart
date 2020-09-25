import 'package:batterydoctor/pages/loginpages/user_info.dart';
import 'package:flutter/material.dart';

// AuthService _authService = AuthService();
// final usersRef = Firestore.instance.collection('Users');

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isAuth = false;
  final _formKey = GlobalKey<FormState>();
  final DateTime timeStamp = DateTime.now();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  // TextEditingController _name = TextEditingController();
  // TextEditingController _phNumber = TextEditingController();
  TextEditingController _rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
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
        )),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Anton',
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: TextFormField(
              //     textCapitalization: TextCapitalization.words,
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return 'Please fill your name';
              //       } else {
              //         return null;
              //       }
              //     },
              //     controller: _name,
              //     decoration: InputDecoration(
              //       filled: true,
              //       hintText: 'Name',
              //       prefixIcon: Icon(Icons.account_circle),
              //       border: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.white),
              //       ),
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: TextFormField(
              //       keyboardType: TextInputType.phone,
              //       validator: (value) {
              //         if (value.isEmpty) {
              //           return 'Please fill your Phone Number';
              //         } else {
              //           return null;
              //         }
              //       },
              //       controller: _phNumber,
              //       decoration: buildInputDecoration('Ph no.')),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please fill valid Email';
                    } else {
                      return null;
                    }
                  },
                  controller: _email,
                  decoration: buildInputDecoration('Email', Icons.email),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  decoration:
                      buildInputDecoration('password', Icons.lock_outline),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value != _password.text) {
                      return 'Please type your password again';
                    } else {
                      return null;
                    }
                  },
                  controller: _rePassword,
                  obscureText: true,
                  decoration:
                      buildInputDecoration('Re-password', Icons.lock_outline),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: InkWell(
                  onTap: () {
                    register();
                  },
                  child: new Container(
                    height: 50.0,
                    decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.white, width: 1.0),
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    child: new Center(
                      child: new Text(
                        'Next',
                        style:
                            new TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              _isAuth ? registerFailed() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  registerFailed() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Unsuccessful Register, Please try again!',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  // createUserInFireStore(userid) async {
  //   final DocumentSnapshot doc = await usersRef.document(userid).get();
  //   if (!doc.exists) {
  //     usersRef.document(userid).setData({
  //       'id': userid,
  //       'username': _name.text,
  //       'email': _email.text,
  //       'password': _password.text,
  //       'phone': _phNumber.text,
  //       'timestamp': timeStamp,
  //     });
  //   }
  // }

  register() async {
    if (_formKey.currentState.validate()) {
      String email = _email.text;
      String password = _password.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FillUserInfo(
            email: email,
            password: password,
          ),
        ),
      );
    }
  }

  InputDecoration buildInputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      filled: true,
      hintText: hintText,
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }
}
