import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  var faker = new Faker();

  String tanggal = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAKER"),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://picsum.photos/id/${870 + index}/200/300",
            ),
            backgroundColor: Colors.grey[300],
          ),
          title: Text("${faker.person.name()}"),
          subtitle: Text(
            "${DateFormat.yMMMEd().add_Hms().format(DateTime.parse(tanggal))}",
          ),
        ),
      ),
    );
  }
}
