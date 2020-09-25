import 'package:batterydoctor/authentication/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

AuthService _authService = AuthService();
final usersRef = Firestore.instance.collection('Users');

class FillUserInfo extends StatefulWidget {
  FillUserInfo({this.email, this.password});

  final String email;
  final String password;

  @override
  _FillUserInfoState createState() => _FillUserInfoState();
}

class _FillUserInfoState extends State<FillUserInfo> {
  bool _isAuth = false;
  final _formKey = GlobalKey<FormState>();
  final DateTime timeStamp = DateTime.now();
  TextEditingController _name = TextEditingController();
  TextEditingController _phNumber = TextEditingController();
  TextEditingController _address = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  autocorrect: false,
                  // keyboardType: TextInputType.emailAddress,
                  controller: _name,
                  decoration:
                      buildInputDecoration('Name', Icons.account_circle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _phNumber,
                  decoration: buildInputDecoration('Phone No.', Icons.phone),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  autocorrect: false,
                  controller: _address,
                  maxLines: 2,
                  decoration:
                      buildInputDecoration('Address', Icons.location_on),
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
                        'Register',
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

  createUserInFireStore(userid) async {
    final DocumentSnapshot doc = await usersRef.document(userid).get();
    if (!doc.exists) {
      usersRef.document(userid).setData({
        'id': userid,
        'username': _name.text,
        'email': widget.email,
        'password': widget.password,
        'phone': _phNumber.text,
        'timestamp': timeStamp,
        'location': _address.text,
      });
    }
  }

  register() async {
    if (_formKey.currentState.validate()) {
      String email = widget.email;
      String password = widget.password;
      dynamic user = await _authService.registerWithEmail(email, password);
      if (user != null) {
        print(user.uid);
        createUserInFireStore(user.uid);
        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        setState(() {
          _isAuth = true;
        });
      }
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
