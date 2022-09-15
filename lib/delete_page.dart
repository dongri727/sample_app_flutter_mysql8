import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'domain/format.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  var res = '';
  var targetId = '';

  Future<void> _delete() async {
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
      "DELETE FROM timeline WHERE id = $targetId",
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
            const Text(
              'Push button to delete',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _delete,
        tooltip: 'delete',
        label: const Text("delete"),
      ),
    );
  }
}