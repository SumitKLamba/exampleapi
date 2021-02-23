import 'package:api_example/services/worldtime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:api_example/services/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel _user;
  String time = 'loading';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  void worldTimeSetup() async{
    WorldTime instance = WorldTime(location: 'Berlin', url: 'Europe/Berlin');
    await instance.getTime();
    setState(() {
      time = instance.time;
    });
  }

  void creatingUser() async{
    WorldTime instance = WorldTime();
    final String name = nameController.text;
    final String jobTitle = jobController.text;
    final UserModel user= await instance.createUser(name, jobTitle);
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    worldTimeSetup();
  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            TextField(
              controller: nameController,
            ),

            TextField(
              controller: jobController,
            ),

            SizedBox(height: 32,),

            _user == null ? Container() :
            Text("The user ${_user.name}, ${_user.id} is created successfully at time ${_user.createdAt.toIso8601String()}"),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          creatingUser();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //     padding: EdgeInsets.all(50),
  //     child: Text(time),),
  //   );
  // }
}
