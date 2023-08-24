import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static void show(
      BuildContext context, int index, Function(int) deleteTaskCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task?'),
          content: Text('Are you sure you want to delete this task?'),
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
                Navigator.of(context).pop();
                deleteTaskCallback(
                    index); // Call the deleteTaskCallback function
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF7C2E62)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
