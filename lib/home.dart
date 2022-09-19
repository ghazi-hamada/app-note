import 'package:flutter/material.dart';
import 'package:sqdlite_/editNote.dart';
import 'package:sqdlite_/sqldb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDB sqldb = SqlDB();
  bool isloding = true;
  List notes = [];
  Future redData() async {
    List<Map> response = await sqldb.redData('SELECT * FROM notes');
    notes.addAll(response);
    isloding = false;
    // if (mounted) {
    setState(() {});
    // }
  }

  @override
  void initState() {
    redData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "addnotes");
          },
        ),
        appBar: AppBar(
          title: const Text('home'),
        ),
        body: isloding
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  // MaterialButton(
                  //     onPressed: () {
                  //       sqldb.myDeleteDatabase();
                  //     },
                  //     child: const Text('delete database')),
                  ListView.builder(
                    itemCount: notes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            title: Text("${notes[index]['title']}"),
                            subtitle: Text("${notes[index]['note']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    int response = await sqldb.daleteData(
                                        "DELETE FROM notes WHERE id = ${notes[index]['id']}");
                                    if (response > 0) {
                                      notes.removeWhere(
                                        (element) =>
                                            element['id'] == notes[index]['id'],
                                      );
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(221, 143, 135, 135),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return EditNote(
                                          title: notes[index]['title'],
                                          note: notes[index]['note'],
                                          color: notes[index]['color'],
                                          id: notes[index]['id'],
                                        );
                                      },
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(221, 143, 135, 135),
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  )
                ],
              ));
  }
}
