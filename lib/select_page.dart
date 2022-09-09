import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'domain/format.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  //今回は国別に絞り込んでいる。ここの自由度も上げたい。
  var targetCountry = ''; // WHERE term
  var selectedId = '';
  var selectedYear = '';
  var selectedName = '';
  var selectedCountry = '';



  Future<void> _select() async {
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

    // make query
    var result = await conn.execute("SELECT * FROM timeline WHERE country = '$targetCountry'");

    // print some result data
    print(result.numOfColumns);
    print(result.numOfRows);
    //print(result.lastInsertID);
    //print(result.affectedRows);


    // print query result
    for (final row in result.rows) {
      setState((){
        selectedYear = row.colAt(1)!;
        selectedName = row.colAt(2)!;
        selectedCountry = row.colAt(3)!;
      });
      // print(row.colAt(0));
      // print(row.colByName("title"));
      // print all rows as Map<String, String>
      //print(row.assoc());
      //as Map<String, dynamic>
      print(row.typedAssoc());
    }

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
                  hintText: "country",
                  onChanged: (text) {
                    targetCountry = text;
                  },
                )
            ),
            const Text(
              'Push button to move:',
            ),

            Text(
              style: Theme.of(context).textTheme.headline4,
              selectedYear,
            ),
            Text(
              style: Theme.of(context).textTheme.headline4,
              selectedName,
            ),
            Text(
              style: Theme.of(context).textTheme.headline4,
              selectedCountry,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _select,
        tooltip: 'select',
        child: const Icon(Icons.add),
      ),
    );
  }
}