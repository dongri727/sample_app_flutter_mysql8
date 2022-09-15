import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'domain/format.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var res = '';
  var targetId = ''; // id to update
  var targetTerm = ''; // column name to update
  var newTerm = ''; // new data to replace

  Future<void> _update() async {
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

    // update some rows
    var res = await conn.execute(
      "UPDATE timeline SET $targetTerm = :$targetTerm WHERE id = $targetId",
      {
        targetTerm: newTerm,
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
                  hintText: "id",
                  onChanged: (text) {
                    targetId = text;
                  },
                )
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Format(
                  hintText: "term",
                  onChanged: (text) {
                    targetTerm = text;
                  },
                )
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Format(
                  hintText: "new term",
                  onChanged: (text) {
                    newTerm = text;
                  },
                )
            ),
            const Text(
              'Push button to update',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _update,
        tooltip: 'update',
        label: const Text("update"),
      ),
    );
  }
}