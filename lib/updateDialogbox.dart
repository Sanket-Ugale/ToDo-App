// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpdateDialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onUpdate;
  String dialogTitle;
  String dialogInputHint;
  UpdateDialogBox(
      {super.key,
      required this.controller,
      required this.onUpdate,
      required this.dialogTitle,
      required this.dialogInputHint});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.yellow.shade300,
      // title: Text("Add Task"),
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(dialogTitle), const CloseButton()],
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: dialogInputHint,
                // label: Text("Task"),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(230, 45),
                backgroundColor: Colors.yellow.shade600,
              ),
              onPressed: onUpdate,
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 20),
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
