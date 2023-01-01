// ignore_for_file: file_names
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:confetti/confetti.dart';

class TodoTile extends StatelessWidget {
  final bool checkedStatus;
  final String title;
  final String subTitle;
  final Function(bool?) onChanged;
  final Function(BuildContext) deleteFunction;
  final Function(BuildContext) updateFunction;
  TodoTile(
      {super.key,
      required this.checkedStatus,
      required this.title,
      required this.subTitle,
      required this.onChanged,
      required this.deleteFunction,
      required this.updateFunction});
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    var edit = FontAwesomeIcons.edit;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(13),
          // padding: EdgeInsets.all(10),
          child: Slidable(
            startActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  // spacing: 1,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.greenAccent,
                  onPressed: updateFunction,
                  icon: edit,
                )
              ],
            ),
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  // spacing: 1,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.red.shade600,
                  onPressed: deleteFunction,
                  icon: FontAwesomeIcons.trash,
                )
              ],
            ),
            child: Container(
              // margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isPlaying) {
                        confettiController.stop();
                      } else {
                        confettiController.play();
                      }
                      isPlaying = !isPlaying;
                    },
                    child: Checkbox(
                      value: checkedStatus,
                      onChanged: onChanged,
                      activeColor: Colors.black,
                    ),
                  ),
                  // Column(
                  //   children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Text(
                            title,
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 18,
                                decoration: checkedStatus
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: title));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 214, 34),
                              content: Text(
                                "Title Copied to Clipboard",
                                textAlign: TextAlign.center,
                              ),
                            ));
                          },
                        ),
                        GestureDetector(
                          child: Text(
                            subTitle,
                            // textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                decoration: checkedStatus
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: subTitle));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 214, 34),
                              content: Text(
                                "SubTitle Copied to Clipboard",
                                textAlign: TextAlign.center,
                              ),
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
