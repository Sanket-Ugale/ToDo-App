// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final titleController;
  final subtitleController;
  VoidCallback onSave;
  String dialogTitleInputHint;
  String dialogSubitleInputHint;
  String dialogTitleText;
  String dialogButtonName;
  String dialogSubitleText;

  DialogBox(
      {super.key,
      required this.subtitleController,
      required this.titleController,
      required this.onSave,
      required this.dialogTitleText,
      required this.dialogTitleInputHint,
      required this.dialogButtonName,
      required this.dialogSubitleText,
      required this.dialogSubitleInputHint});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.yellow.shade300,
      // title: Text("Add Task"),
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(dialogTitleText.toString()), const CloseButton()],
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: dialogTitleInputHint,
                // label: Text("Task"),
              ),
            ),
            TextField(
              controller: subtitleController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: dialogSubitleInputHint,
                // label: Text("Task"),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 45),
                backgroundColor: Colors.yellow.shade600,
              ),
              onPressed: onSave,
              child: Text(
                dialogButtonName,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: Text("Close"),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: Text("Add"),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
