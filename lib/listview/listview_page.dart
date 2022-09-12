
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/format.dart';
import '../domain/list_selected.dart';
import 'listview_model.dart';

class ListviewPage extends StatelessWidget{
  const ListviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListviewModel>(
        create: (_) => ListviewModel()..fetchListSelected(),
        child: Scaffold(
        appBar: AppBar(
        title: const Text('search & results'),
    ),
           body: Column(
              children: [
               Container(
                  child: Consumer<ListviewModel>(builder: (context, model,child) {
                     return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Format(
                              hintText: "column1",
                              onChanged: (text) {
                              model.targetColumn1 = text;
                              },)
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                               child: Format(
                                  hintText: "column2",
                                  onChanged: (text) {
                                  model.targetColumn2 = text;
                                  },)
                           ),
                          Padding(
                                 padding: const EdgeInsets.all(5.0),
                                  child: Format(
                                      hintText: "and / or",
                                      onChanged: (text) {
                                      model.logique = text;
                                      },)
                              ),

                          Padding(
                                padding: const EdgeInsets.all(5.0),
                                 child: Format(
                                   hintText: "search term 1",
                                    onChanged: (text) {
                                    model.searchTerm1 = text;
                                    },)
                          ),
                          Padding(
                                padding: const EdgeInsets.all(5.0),
                                   child: Format(
                                      hintText: "search term 2",
                                      onChanged: (text) {
                                      model.searchTerm2 = text;
                                      },)
                          ),
                           Padding(
                                padding: const EdgeInsets.all(10.0),
                                 child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.amber),
                                    onPressed: () {
                                    model.fetchListSelected();
                                    },
                                     child: const Text('search'),
                                  ),
                            ),
                    ],);
                 }),
            ),
              Container(
                  child: Consumer<ListviewModel>(builder: (context, model,child){
                      final List<ListSelected>? selected = model.selected;

                      if (selected == null) {
                          return const CircularProgressIndicator();
                      }
                      final List<Widget> widgets = selected
                      .map(
                          (selected) =>
                       Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                              child: Row(
                                  children: [
                                   Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text(selected.id),
                                            Text(selected.year),
                                          ],),
                                      )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(selected.name)),
                                    Expanded(
                                        flex: 3,
                                        child: Text(selected.country)),
                                  ],),
                          ),
                        ),
                      )
                      .toList();
                       return ListView(
                          children: widgets,
                        );}),
              ) ,
          ],),
        ),
    );}
  }
