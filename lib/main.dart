import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

void main() {
  runApp(const MyApp());
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
  late String id;
  late String email;
  late String name;
  late String image;

  @override
  void initState() {
    id = "*****";
    email = "*****";
    name = "*****";
    image = "*****";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("http GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(120),
              ),
            ),
            Text("id: $id", style: TextStyle(fontSize: 20)),
            Text("name: $email", style: TextStyle(fontSize: 20)),
            Text("email: $name", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                var myResponse = await myhttp
                    .get(Uri.parse("https://reqres.in/api/users/2"));
                if (myResponse.statusCode == 200) {
                  print("GET data success");
                  Map<String, dynamic> data =
                      json.decode(myResponse.body) as Map<String, dynamic>;
                  print(data["data"]);
                  setState(() {
                    id = data["data"]["id"].toString();
                    email = data["data"]["email"].toString();
                    image = data["data"]["avatar"].toString();
                    name =
                        "${data["data"]["first_name"]} ${data["data"]["last_name"]}";
                  });
                } else {
                  print(
                      "Response error! 💥 Status Code = ${myResponse.statusCode}");
                  setState(() {
                    print(
                        "Response error! 💥 Status Code = ${myResponse.statusCode}");
                  });
                }
              },
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
