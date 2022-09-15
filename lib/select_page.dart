import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import 'domain/format.dart';
import 'update_page.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {

  var targetColumn1 = '';
  var targetColumn2 = '';
  var searchTerm1 = '';
  var searchTerm2 = '';
  var logique = '';

  List<Map<String, String>> displayList = [];

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
    var result = await conn.execute(
        "SELECT * FROM timeline WHERE $targetColumn1 = '$searchTerm1' $logique $targetColumn2 = '$searchTerm2' ORDER BY year ASC");

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
        'selectedCountry': row.colAt(3)!,
      };
      list.add(data);
    }
    print('je suis la');

    setState(() {
      displayList = list;
    });

      // print(row.colAt(0));
      // print(row.colByName("title"));
      // print all rows as Map<String, String>
      //print(row.assoc());
      //as Map<String, dynamic>
      //print(row.typedAssoc());

    // close all connections
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
          children:[
            Expanded(
              flex: 2,
              child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Format(
                          hintText: "column1",
                          onChanged: (text) {
                            targetColumn1 = text;
                          },
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Format(
                          hintText: "search term 1",
                          onChanged: (text) {
                            searchTerm1= text;
                          },
                        )
                    ),

                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Format(
                          hintText: "and / or",
                          onChanged: (text) {
                            logique = text;
                          },
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Format(
                          hintText: "column2",
                          onChanged: (text) {
                            targetColumn2 = text;
                          },
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Format(
                          hintText: "search term 2",
                          onChanged: (text) {
                            searchTerm2= text;
                          },
                        )
                    ),
                  ]),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
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
            ),
          ]),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _select,
        tooltip: 'select',
        label: const Text("select"),
      ),
    );
  }
}

