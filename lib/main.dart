import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './models/userModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> allUser = [];

  Future getAllUser() async {
    try {
      var response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      List data = (jsonDecode(response.body) as Map<String, dynamic>)["data"];
      data.forEach(
        (element) {
          allUser.add(
            UserModel.fromJson(element),
          );
        },
      );
    } catch (e) {
      print("something wrong");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Model"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("LOADING 🟢🟡🔴"),
              );
            } else {
              if (allUser.length == 0) {
                return Center(
                  child: Text("data no available"),
                );
              }
              return ListView.builder(
                itemCount: allUser.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    backgroundImage: NetworkImage(allUser[index].avatar),
                  ),
                  title: Text(
                      "${allUser[index].firstName} ${allUser[index].lastName}"),
                  subtitle: Text("${allUser[index].email}"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
