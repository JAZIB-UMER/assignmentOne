import 'package:assignment/hive_asif/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box('notes');
}
