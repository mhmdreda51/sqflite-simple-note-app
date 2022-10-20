import 'package:flutter/material.dart';

import '../constant/route.dart';
import '../database/sql_db.dart';
import 'home.dart';

class EditNote extends StatefulWidget {
  const EditNote({
    Key? key,
    required this.note,
    required this.title,
    required this.color,
    required this.id,
  }) : super(key: key);
  final String note;
  final String title;
  final String color;
  final int id;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController noteCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController colorCtr = TextEditingController();

  SqlDB sqlDB = SqlDB();

  @override
  void initState() {
    noteCtr.text = widget.note;
    titleCtr.text = widget.title;
    colorCtr.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
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
//                       int response = await sqlDB.updateData('''
//                           UPDATE notes SET
//                           note  =  "${noteCtr.text}",
//                           title = "${titleCtr.text}",
//                           color = "${colorCtr.text}"
//                           WHERE id = ${widget.id}
// ''');
                      int response = await sqlDB.updateDataShortcut(
                        id: widget.id.toString(),
                        table: "Notes",
                        values: {
                          "note": noteCtr.text,
                          "title": titleCtr.text,
                          "color": colorCtr.text
                        },
                      );
                      if (response != 0) {
                        MagicRouter.navigateTo(const HomeScreen());
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: const Text("Edit Note"),
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
