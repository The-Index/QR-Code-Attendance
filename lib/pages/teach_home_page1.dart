import 'package:flutter/material.dart';
import 'package:miniproject/services/teacher_authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherHomePage extends StatefulWidget {
  TeacherHomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;

  final String userId;

  @override
  State<StatefulWidget> createState() => new _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  //final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //final _textEditingController = TextEditingController();

  //bool _isEmailVerified = false;
  String classname;
  String str;

  @override
  void initState() {
    super.initState();

    //_checkEmailVerification();
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Smart Attendance'),
          backgroundColor: Colors.redAccent[400],
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 12.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
        body: Wrap(
          direction: Axis.vertical,
          spacing: 3.0, // gap between adjacent widgets
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                width: 300,
                height: 50,
                alignment: Alignment(100, 20),
                decoration: BoxDecoration(
                  color: Colors.cyan[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Welcome,Teacher',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            
               Container(
               margin: new EdgeInsets.all(20.0),
                width: 320.0,
                 height: 400.0,
                //alignment: Alignment(100, 20),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                        width: 250,
                        height: 50,
                        alignment: Alignment(50, 30),
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: Text(
                            'select your class',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    //selectclassInput()
                  ],
                ),
              ),
            
          ],
        ));
  }

  Widget selectclassInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (value) => value.isEmpty ? 'Enter classname first' : null,
        onSaved: (value) => classname = value.trim(),
      ),
    );
  }

  Future<void> getData()
  async {
    var result =
    await Firestore.instance.collection('users')
        .document('HHM9saJLvZ72Sh40BeM6')
        .collection('cgv')
        .document('30.04.2020').get();
    setState(() {
      str = result['count'].toString();
    });
  }
}
