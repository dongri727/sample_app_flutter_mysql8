import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../domain/list_selected.dart';


class ListviewModel extends ChangeNotifier {
  List<ListSelected>? selected;

  // 接続する
  void fetchListSelected() async {
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

    // make query　絞り込む
    var result = await conn.execute(
        "SELECT * FROM timeline WHERE $targetColumn1 = '$searchTerm1' $logique $targetColumn2 = '$searchTerm2' ORDER BY year");


    // print all rows as Map<String, String>
    //print(row.assoc());
    //TODO これがMapらしい
    //print all rows as Map<String, dynamic>
    print(row.typedAssoc());

    //表示する
    //todo  query result firestoreからMySQLに差し替える 用語が違ってる。
    final List<ListSelected> selected = snapshot.docs.map((DocumentSnapshot document) {
      Map<String?, dynamic> data = document.data() as Map<String?, dynamic>;
      //todo　ここもfirestoreの用語？
      final String id = document.id;
      final String year = data['b_year'];
      final String name = data['c_name'];
      final String country = data['d_country'];

      //以下は「複数取得したうち最後のデータ」
      //これがid
      print(row.colAt(0));
      //これがyear
      print(row.colAt(1));
      //これがname
      print(row.colAt(2));
      //これがcountry
      print(row.colAt(3));


      return ListSelected(
        id,
        year,
        name,
        country,
      );
    }).toList();

    this.selected = selected;
    notifyListeners();
  }

  //これ何？
  String? id;
  String? year;
  String? name;
  String? country;

  //検索結果
  String? selectedId;
  String? selectedYear;
  String? selectedName;
  String? selectedCountry;

  //検索用語
  String? targetColumn1;
  String? targetColumn2;
  String? searchTerm1;
  String? searchTerm2;
  String? logique;

  final clearController = TextEditingController();
}
