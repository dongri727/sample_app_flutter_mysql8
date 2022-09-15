import 'package:flutter/material.dart';

import 'delete_page.dart';
import 'insert_page.dart';
import 'read_all_page.dart';
import 'select_page.dart';
import 'update_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                SizedBox(height: 200),

                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Flutter MySQL8 Sample',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReadAllPage(title: 'Flutter MySQL Insert Sample'),
                        ),
                      );
                    },
                    child: const Text(
                      "Read All Page",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InsertPage(title: 'Flutter MySQL Insert Sample'),
                        ),
                      );
                    },
                    child: const Text(
                      "Insert Page",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdatePage(title: 'Flutter MySQL Update Sample'),
                        ),
                      );
                    },
                    child: const Text(
                      "Update Page",
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SelectPage(title: 'Flutter MySQL Select Sample'),
                        ),
                      );
                    },
                    child: const Text(
                      "Select Page",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeletePage(title: 'Flutter MySQL Delete Sample'),
                        ),
                      );
                    },
                    child: const Text(
                      "Delete Page",
                    ),
                  ),
                ),
              ],
            )

        )
    );
  }

}
