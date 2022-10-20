import 'package:flutter/material.dart';
import 'package:sqflite_example/constant/route.dart';
import 'package:sqflite_example/pages/home.dart';

import '../constant/strings.dart';
import '../database/sql_db.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController noteCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController colorCtr = TextEditingController();
  SqlDB sqlDB = SqlDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: noteCtr,
                    decoration: const InputDecoration(hintText: "Note"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: titleCtr,
                    decoration: const InputDecoration(hintText: "Tile"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: colorCtr,
                    decoration: const InputDecoration(hintText: "Color"),
                  ),
                  const SizedBox(height: 50),
                  MaterialButton(
                    onPressed: () async {
//                       int response = await sqlDB.insertData('''
//                           INSERT INTO Notes ('note','title','color')
//                           VALUES ("${noteCtr.text}","${titleCtr.text}","${colorCtr.text}")

// ''');
                      int response = await sqlDB.insertDataShortcut("Notes", {
                        "note": noteCtr.text,
                        "title": titleCtr.text,
                        "color": colorCtr.text
                      });
                      if (response != 0) {
                        MagicRouter.navigateTo(const HomeScreen());
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: const Text("Add Note"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
