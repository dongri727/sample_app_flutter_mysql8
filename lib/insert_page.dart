import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'domain/format.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  var newYear = '';
  var newName = '';
  var newCountry = '';

  Future<void> _insert() async {
    print("Connecting to mysql server...");

    // create connection
    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",   //when you use simulator
      //host: "10.0.2.2",   when you use emulator
      //host: "localhost"
      port: 3306,
      userName: "root",
      password: "myPassword", // you need to replace with your password
      databaseName: "myDatabase", // you need to replace with your db name
    );

    await conn.connect();

    print("Connected");

    // insert some rows
    var res = await conn.execute(
      "INSERT INTO timeline (id, year, name, country) VALUES (:id, :year, :name, :country)",
      {
        "id": null, //if you set it auto increment
        "year": newYear,
        "name": newName,
        "country": newCountry,
      },
    );

    print(res.affectedRows);


    // close all connections
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Format(
                  hintText: "year",
                  onChanged: (text) {
                    newYear = text;
                  },
                )
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Format(
                  hintText: "name",
                  onChanged: (text) {
                    newName = text;
                  },
                )
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Format(
                  hintText: "country",
                  onChanged: (text) {
                    newCountry = text;
                  },
                )
            ),
            const Text(
              'Push button to insert',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _insert,
        tooltip: 'insert',
        label: const Text("insert"),
      ),
    );
  }
}
