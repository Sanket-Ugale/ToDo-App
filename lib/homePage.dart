// ignore_for_file: file_names

// import 'package:confetti/confetti.dart';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:xtodo/data/database.dart';
import 'package:xtodo/dialogBox.dart';
import 'package:xtodo/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box("mybox");
  @override
  void initState() {
    super.initState();
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final confettiController = ConfettiController(duration: Duration(seconds: 3));
  ToDoDatabase db = ToDoDatabase();
  bool isPlaying = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    confettiController.dispose();
    _subtitleController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            leading: const Icon(FontAwesomeIcons.listCheck),
            title: const Text("X TODO"),
            centerTitle: true,
            elevation: 0.5,
          ),
          backgroundColor: Colors.yellow.shade100,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.yellow.shade600,
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                title: db.todoList[index][0],
                subTitle: db.todoList[index][1],
                checkedStatus: db.todoList[index][2],
                onChanged: (value) => checkBoxChanged(value!, index),
                deleteFunction: (context) => deleteTask(index),
                updateFunction: (context) => updateTask(index),
              );
            },
          ),
        ),
        ConfettiWidget(
          blastDirection: pi / 2,
          confettiController: confettiController,
          shouldLoop: false,
        )
      ],
    );
  }

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.todoList[index][2] = !db.todoList[index][2];
      db.updateData();
      if (!value) {
        confettiController.stop();
      } else {
        confettiController.play();
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          subtitleController: _subtitleController,
          titleController: _titleController,
          onSave: saveNewTask,
          dialogTitleText: 'Add Task',
          dialogTitleInputHint: 'Add a new Task',
          dialogSubitleText: 'Add Subtitle',
          dialogSubitleInputHint: 'Add task subtitle',
          dialogButtonName: 'Add',
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_titleController.text, _subtitleController.text, false]);
      _titleController.clear();
      _subtitleController.clear();
      Navigator.of(context).pop();
      db.updateData();
    });
  }

  deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.updateData();
    });
  }

  updateTask(int index) {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        titleController: _titleController,
        subtitleController: _subtitleController,

        onSave: () {
          db.todoList[index][0] = _titleController.text;
          db.todoList[index][1] = _subtitleController.text;
          setState(() {
            Navigator.of(context).pop();
            _titleController.clear();
            _subtitleController.clear();
          });
        },
        // updateOldTask(index),

        dialogButtonName: 'Update',
        dialogSubitleInputHint: 'Update old Subtitle',
        dialogSubitleText: 'Update Subtitle',
        dialogTitleInputHint: 'Update old Task',
        dialogTitleText: 'Update Task',
      ),
    );
  }

  updateOldTask(int index) {
    db.todoList[index][0] = _titleController.text;
    db.todoList[index][0] = _subtitleController.text;
    setState(() {
      _titleController.clear();
      _subtitleController.clear();
      db.updateData();
    });
  }
}
