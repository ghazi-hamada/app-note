import 'package:flutter/material.dart';
import 'package:sqdlite_/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final sqlDB = SqlDB();
  final fromState = GlobalKey<FormState>();
  final note = TextEditingController();
  final title = TextEditingController();
  final color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Form(
              key: fromState,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(hintText: 'title'),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(hintText: 'note'),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(hintText: 'color'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                              int response = await sqlDB.insertData('''
                      INSERT INTO `notes` (`title`, `note`, `color` )
                      VALUES  ('${title.text}', '${note.text}', '${color.text}')
                            ''');
                      
                      print(response);
                      response > 0
                          // ignore: use_build_context_synchronously
                          ? Navigator.pushNamedAndRemoveUntil(
                              context, 'home', (route) => false)
                          : null;
                    },
                    child: const Text('Add Notes 🙂👍'),
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
