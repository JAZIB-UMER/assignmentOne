import 'package:assignment/sqflite/db_handler.dart';
import 'package:assignment/sqflite/notes_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddDataScreen extends StatefulWidget {
  String? title, decription, email, age;
  int? id;
  AddDataScreen(
      {super.key, this.title, this.age, this.email, this.decription, this.id});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  var titleController = TextEditingController();
  var ageController = TextEditingController();
  var descController = TextEditingController();
  var emailController = TextEditingController();
  DBHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text(
          'Add Data',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: widget.title ?? 'Title',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                  hintText: widget.age ?? 'Age',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descController,
              decoration: InputDecoration(
                  hintText: widget.decription ?? 'Description',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: widget.email ?? 'Email',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple))),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.id != null
                    ? ElevatedButton(
                        onPressed: () {
                          //------------------------------------------
                          dbHelper!
                              .update(NotesModel(
                                  id: widget.id,
                                  title: titleController.text.toString() == ''
                                      ? widget.title!
                                      : titleController.text.toString(),
                                  age: int.parse(ageController.text == ''
                                      ? widget.age!
                                      : ageController.text),
                                  description: descController.text == ''
                                      ? widget.decription!
                                      : descController.text,
                                  email: emailController.text == ''
                                      ? widget.email!
                                      : emailController.text))
                              .then((value) {
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {});
                        },
                        style: const ButtonStyle(
                            side: MaterialStatePropertyAll(
                                BorderSide(color: Colors.purple))),
                        child: const Text(
                          'Update',
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          dbHelper!
                              .insert(NotesModel(
                                  title: titleController.text.toString() == ''
                                      ? 'Empty'
                                      : titleController.text.toString(),
                                  age: int.parse(ageController.text == ''
                                      ? '0'
                                      : ageController.text),
                                  description:
                                      descController.text.toString() == ''
                                          ? 'Empty'
                                          : descController.text.toString(),
                                  email: emailController.text.toString() == ''
                                      ? 'Empty'
                                      : emailController.text.toString()))
                              .then((value) {
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {});
                        },
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                              BorderSide(color: Colors.purple)),
                        ),
                        child: const Text('Add'),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
