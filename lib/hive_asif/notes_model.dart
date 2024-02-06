import 'package:hive_flutter/hive_flutter.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)

//Id of this Model...Can create different Ids for models
class NotesModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  NotesModel({required this.title, required this.description});
}
