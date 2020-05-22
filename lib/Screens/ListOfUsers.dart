import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListofUsers extends StatefulWidget {
  @override
  _ListofUsersState createState() => _ListofUsersState();
}

class _ListofUsersState extends State<ListofUsers> {
  String url = "https://randomuser.me/api/?results=20";
  List data;

  Future makeRequestsforusers() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});


    // data = extractdata["results"];
    // print(data[0]["name"]);
// OR we can write print(extractdata["results"][0]["name"]);
setState(() {
      var extractdata = JsonDecoder().convert(response.body);
      data=extractdata["results"];
});

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.makeRequestsforusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Users'),

      ),
      body: ListView.builder(
         
        itemCount: data==null?0:data.length,
           itemBuilder: (context, i) {
return ListTile(
  title: Text(data[i]['name']['first']+' '+data[i]['name']['last']),
  subtitle:Text(data[i]['location']['city']+', '+data[i]['location']['state']+', '+data[i]['location']['country']) ,
  leading: CircleAvatar(
    radius: 25,
    backgroundImage: NetworkImage(data[i]['picture']['thumbnail']),
  ),
  onTap:(){
    
  } ,
);
           }, 
           
        ),
    );
  }
}
