import 'package:flutter/material.dart';

class AddTaskDialog {
  static void show(BuildContext context, Function(String) addTaskCallback) {
    final TextEditingController _taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
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
                String task = _taskController.text.trim();
                if (task.isNotEmpty) {
                  addTaskCallback(
                      task); // Use the addTaskCallback passed from outside
                }
                Navigator.of(context).pop();
                _taskController.clear();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF7C2E62)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
