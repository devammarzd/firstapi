
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_first_api/Screens/ListOfUsers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = "https://randomuser.me/api/";
List data;
String dataextract;
String name='';
  Future makeRequestforbody() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      name=response.body;
    });
    // name=response.body;
  }

  Future makeRequestsingleitem() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
var extractdata=JsonDecoder().convert(response.body);


data=extractdata["results"];
print(data[0]["name"]);
// OR we can write print(extractdata["results"][0]["name"]);
setState(() {
  name=extractdata["results"][0]["name"]["first"];
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First Api'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Text(name),
          ),
          Center(
            child: RaisedButton(
                child: Text('Make Request to print body of a single user'),
                onPressed: () {
                  makeRequestforbody();
                }),
          ),
          RaisedButton(
              child: Text('To request first name only'),
              onPressed: () {
                makeRequestsingleitem();
              }),
               RaisedButton(
              child: Text('List of users'),
              onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ListofUsers()));
              }),
        ],
      ),
    );
  }
}
