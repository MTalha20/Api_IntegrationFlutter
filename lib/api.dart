import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getUser() async {
    var Data = [];
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
    var jsondata = jsonDecode(response.body);

    for (var i in jsondata) {
      UserModel user = UserModel(i["name"], i["username"], i["email"]);
      Data.add(user);
    }
    return Data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: const Text("No Api Detected"),
          );
        } else
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data[i].name),
                  subtitle: Text(snapshot.data[i].username),
                );
              });
      },
    ));
  }
}

class UserModel {
  var name;
  var username;
  var email;

  UserModel(this.name, this.username, this.email);
}
