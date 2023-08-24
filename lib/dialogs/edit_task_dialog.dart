import 'package:flutter/material.dart';

class EditTaskDialog {
  static void show(BuildContext context, int index,
      Function(int, String) updateTaskCallback, List<String> tasks) {
    final TextEditingController _taskController =
        TextEditingController(text: tasks[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextFormField(
            controller: _taskController,
            style: TextStyle(fontSize: 20),
            maxLines: null,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF7C2E62)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String updatedTask = _taskController.text.trim();
                if (updatedTask.isNotEmpty) {
                  updateTaskCallback(index, updatedTask);
                }
                Navigator.of(context).pop();
                _taskController.clear();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF7C2E62)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
