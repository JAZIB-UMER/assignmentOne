import 'package:assignment/sqflite/add_data.dart';
import 'package:assignment/sqflite/db_handler.dart';
import 'package:assignment/sqflite/notes_model.dart';
import 'package:flutter/material.dart';

class SqfLiteScreen extends StatefulWidget {
  const SqfLiteScreen({super.key});

  @override
  State<SqfLiteScreen> createState() => _SqfLiteScreenState();
}

class _SqfLiteScreenState extends State<SqfLiteScreen> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('DATA',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () => loadData(),
        child: FutureBuilder(
            future: notesList,
            builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
              return snapshot.data?.length != null
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: ValueKey<int>(snapshot.data![index].id!),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete_forever),
                          ),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              dbHelper!.delete(snapshot.data![index].id!);
                              notesList = dbHelper!.getNotesList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              //color: Colors.grey[100],
                              shape: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            AddDataScreen(
                                                              id: snapshot
                                                                  .data![index]
                                                                  .id,
                                                              title: snapshot
                                                                  .data![index]
                                                                  .title,
                                                              email: snapshot
                                                                  .data![index]
                                                                  .email,
                                                              decription: snapshot
                                                                  .data![index]
                                                                  .description,
                                                              age: snapshot
                                                                  .data![index]
                                                                  .age
                                                                  .toString(),
                                                            )));
                                              },
                                              child: const Text('UPDATE'))
                                        ],
                                      ),
                                      //-------------------------------------------
                                      ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        trailing: Text(
                                          snapshot.data![index].title
                                              .toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        title: Text('Name'),
                                      ),
                                      Divider(),
                                      ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        trailing: Text(
                                          snapshot.data![index].age.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        title: Text('Age'),
                                      ),
                                      Divider(),
                                      ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        trailing: Text(
                                          snapshot.data![index].description
                                              .toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        title: Text('Description'),
                                      ),
                                      Divider(),
                                      ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        trailing: Text(
                                          snapshot.data![index].email
                                              .toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        title: Text('email'),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text(
                      'EMPTY',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddDataScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
