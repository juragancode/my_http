import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilResponse = "data not available";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("http POST"),
      ),
      body: ListView(
        padding: EdgeInsets.all(26),
        children: [
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              var myResponse = await http.post(
                Uri.parse("https://reqres.in/api/users"),
                body: {"name": nameC.text, "job": jobC.text},
              );

              // Map<String, dynamic> data = json.decode(myResponse.body) as Map<String, dynamic>;
              Map<String, dynamic> data =
                  jsonDecode(myResponse.body) as Map<String, dynamic>;
              setState(() {
                hasilResponse = "${data["name"]} - ${data["job"]}";
              });
            },
            child: Text("Save"),
          ),
          SizedBox(height: 50),
          Divider(color: Colors.black),
          SizedBox(height: 10),
          Center(
            child: Text(
              hasilResponse,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
