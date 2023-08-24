// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// DateHeader Widget to add Current Date & Year
class DateHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final DateFormat dateFormat = DateFormat('MMMM d, yyyy');

    return Center(
      child: Card(
        color: Color(0xFF7C2E62), // Set the background color of the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateFormat.format(currentDate),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Set text color to white
              ),
              SizedBox(
                  height:
                      10), // Add some spacing between the date and the task list
            ],
          ),
        ),
      ),
    );
  }
}
