import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'update_page.dart';

class ReadAllPage extends StatefulWidget {
  const ReadAllPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<ReadAllPage> createState() => _ReadAllPageState();
}

class _ReadAllPageState extends State<ReadAllPage> {

  List<Map<String, String>> displayList = [];

  Future<void> _readAll() async {
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
    var result = await conn.execute("SELECT * FROM timeline ORDER BY year ASC");

    // print some result data
    //print(result.numOfColumns);
    //print(result.numOfRows);
    //print(result.lastInsertID);
    //print(result.affectedRows);


    // print query result
    List<Map<String, String>> list = [];
    for (final row in result.rows) {
      final data = {
        'selectedId': row.colAt(0)!,
        'selectedYear': row.colAt(1)!,
        'selectedName': row.colAt(2)!,
        'selectedCountry': row.colAt(3)!
      };
      list.add(data);
    }
    print('je suis la');

    setState(() {
      displayList = list;
    });

    // close all connections
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child:
        Column(children: displayList.map<Widget>((data) {
          return Card(
              child: ListTile(
                leading: Text(data['selectedYear']?? ""),
                title: Text(data['selectedName']?? ""),
                subtitle: Text(data['selectedCountry']?? ""),
                trailing: TextButton(
                  child: const Text("update"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdatePage(title: data['selectedId']?? "")),
                    );
                  },
                ),
              )
          );
        }
        ).toList()
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _readAll,
        tooltip: 'ReadAll',
        label: const Text("read all"),
      ),
    );
  }
}