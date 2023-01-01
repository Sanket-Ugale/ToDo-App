import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  final _mybox = Hive.box("mybox");
  List todoList = [];
  void createInitialData() {
    todoList = [
      ["Task 1", "Subtitle 1", true],
      ["Task 2", "Subtitle 2", false],
    ];
  }

  void loadData() {
    todoList = _mybox.get("TODOLIST");
  }

  void updateData() {
    _mybox.put("TODOLIST", todoList);
  }
}
