// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/date_header.dart';
import 'package:to_do_list/dialogs/add_task_dialog.dart';
import 'package:to_do_list/dialogs/edit_task_dialog.dart';
import 'package:to_do_list/dialogs/delete_confirmation_dialog.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _myBox = Hive.box<String>('mybox');
  final _isCheckedBox = Hive.box<bool>('isCheckedBox');

  List<String> tasks = [];
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    tasks = _myBox.values.toList();

    // Retrieve checked states from Hive if they exist
    if (_isCheckedBox.isNotEmpty) {
      isCheckedList = _isCheckedBox.values.toList();
    } else {
      isCheckedList = List.generate(tasks.length, (index) => false);
    }
  }

  void addTask(String task) {
    setState(() {
      tasks.add(task);
      isCheckedList.add(false);
      _myBox.add(task);
      _isCheckedBox.add(false); // Add initial unchecked state
    });
  }

  void updateTask(int index, String updatedTask) {
    setState(() {
      tasks[index] = updatedTask;
      _myBox.putAt(index, updatedTask);
    });
  }

  void toggleTaskCheckedState(int index) {
    setState(() {
      isCheckedList[index] = !isCheckedList[index];
      _isCheckedBox.putAt(index, isCheckedList[index]);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      isCheckedList.removeAt(index);
      _myBox.deleteAt(index);
      _isCheckedBox.deleteAt(index); // Also delete the checked state
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void _showAddDialog(BuildContext context) {
    AddTaskDialog.show(context, addTask);
  }

  void _showEditDialog(BuildContext context, int index) {
    EditTaskDialog.show(context, index, updateTask, tasks);
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    DeleteConfirmationDialog.show(context, index, deleteTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('TODO List'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateHeader(), // DateHeader widget
          Expanded(
            // If list(tasks) is empty relevant text and image will be displayed
            child: tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'Images/image.png',
                          width: 250,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          'Add a task to get started',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  )
                // If list(tasks) is not empty a scrollable list is generated using ListView.builder
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        elevation: 4.0, // Add elevation for a shadow effect
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                toggleTaskCheckedState(index);
                              });
                            },
                            child: ListTile(
                              leading: Checkbox(
                                activeColor: Color(0xFF7C2E62),
                                checkColor: Colors.white,
                                value: isCheckedList[index],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isCheckedList[index] = newValue!;
                                  });
                                },
                              ),
                              title: Text(
                                tasks[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: isCheckedList[index]
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: isCheckedList[index]
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        _showEditDialog(context, index);
                                      },
                                      color: Color(0xFF7C2E62)),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(
                                            context, index);
                                      },
                                      color: Color(0xFF7C2E62)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 55.0,
        width: 55.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              _showAddDialog(context);
            },
            child: Icon(
              Icons.add,
              size: 30.0,
            ),
            backgroundColor: Color(0xFF7C2E62),
          ),
        ),
      ),
    );
  }
}
