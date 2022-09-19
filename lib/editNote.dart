import 'package:flutter/material.dart';
import 'package:sqdlite_/sqldb.dart';

class EditNote extends StatefulWidget {
  final title;
  final note;
  final color;
  final id;
  const EditNote({Key? key, this.title, this.note, this.color, this.id})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final sqlDB = SqlDB();
  final fromState = GlobalKey<FormState>();
  final note = TextEditingController();
  final title = TextEditingController();
  final color = TextEditingController();
  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
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
                      int response = await sqlDB.updateData('''
                          UPDATE notes SET 
                          note = "${note.text}",
                          title = "${title.text}",
                          color = "${color.text}"
                          WHERE id = ${widget.id}
                    ''');
                      print(response);
                      response > 0
                          // ignore: use_build_context_synchronously
                          ? Navigator.pushNamedAndRemoveUntil(
                              context, 'home', (route) => false)
                          : null;
                    },
                    child: const Text('Edit Notes 🙂👍'),
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
