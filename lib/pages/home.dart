import 'package:flutter/material.dart';
import 'package:sqflite_example/constant/route.dart';
import 'package:sqflite_example/pages/add_note.dart';

import '../constant/strings.dart';
import '../database/sql_db.dart';
import 'edit_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDB sqlDB = SqlDB();
  List notes = [];
  bool isLoading = true;
  Future readData() async {
    // List<Map> response = await sqlDB.readData(
    //   "SELECT * FROM ${AppStrings.tableName}",
    // );
    List<Map> response = await sqlDB.readDataShortcut("Notes");
    notes.addAll(response);
    
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => sqlDB.deleteDB(),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
      body: isLoading == false
          ? Container(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${notes[index]["title"]}"),
                          subtitle: Text("${notes[index]["note"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  // int response = await sqlDB.deleteData(
                                  //   " DELETE FROM Notes WHERE id = ${notes[index]["id"]}",
                                  // );
                                  int response = await sqlDB.deleteDataShortcut(
                                      id: notes[index]["id"], table: "Notes");
                                  if (response != 0) {
                                    notes.removeWhere((element) =>
                                        element["id"] == notes[index]["id"]);
                                    setState(() {});
                                  }
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => MagicRouter.navigateTo(
                                  EditNote(
                                    color: notes[index]["color"],
                                    id: notes[index]["id"],
                                    note: notes[index]["note"],
                                    title: notes[index]["title"],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10.0);
                    },
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => MagicRouter.navigateTo(const AddNotes()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
