import 'package:assignment/hive_asif/boxes.dart';
import 'package:assignment/hive_asif/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HiveAsifScreen extends StatefulWidget {
  const HiveAsifScreen({super.key});

  @override
  State<HiveAsifScreen> createState() => _HiveAsifScreenState();
}

class _HiveAsifScreenState extends State<HiveAsifScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue,
        title: const Text(
          'Hive',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            return box.length > 0
                ? ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      var data = box.values.toList().cast<NotesModel>();
                      return Dismissible(
                        key: ValueKey<NotesModel>(data[index]),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete_forever),
                        ),
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            delete(data[index]);
                          });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      data[index].title.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          _showMyDialog(
                                              notesmodel: data[index],
                                              title:
                                                  data[index].title.toString(),
                                              description: data[index]
                                                  .description
                                                  .toString());
                                        },
                                        child: const Icon(Icons.edit)),
                                  ],
                                ),
                                Text(data[index].description.toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                    'EMPTY',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future _showMyDialog(
      {NotesModel? notesmodel,
      String title = '',
      String description = ''}) async {
    titleController.text =
        title.isNotEmpty ? title.toString() : titleController.text;
    descriptionController.text = description.isNotEmpty
        ? description.toString()
        : descriptionController.text;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(title.isEmpty ? 'ADD DATA' : 'UPDATE'),
            ),
            content:
                //SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.2,
                //   width: double.infinity,
                // ),
                SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              title.isEmpty
                  ? TextButton(
                      onPressed: () {
                        final data = NotesModel(
                            title: titleController.text,
                            description: descriptionController.text);
                        final box = Boxes.getData();
                        if (titleController.text.isNotEmpty ||
                            descriptionController.text.isNotEmpty) {
                          box.add(data);
                          titleController.clear();
                          descriptionController.clear();
                        } else {
                          Fluttertoast.showToast(msg: 'Empty Fields');
                        }
                      },
                      child: Text('Add'))
                  : TextButton(
                      onPressed: () {
                        notesmodel!.title = titleController.text;
                        notesmodel.description = descriptionController.text;
                        notesmodel.save();
                        titleController.clear();
                        descriptionController.clear();
                        Navigator.pop(context);
                      },
                      child: Text('Update')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }
}
