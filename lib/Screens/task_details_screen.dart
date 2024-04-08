import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_task_daily/model/task_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Todo item;

  const TaskDetailsScreen({super.key, required this.item});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final _formField = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item.title;
    _descriptionController.text = widget.item.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details screen'),
        backgroundColor: Color(0xFFCAF4DD),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formField,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Title',
                    hintText: 'Title',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter title';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Description',
                    hintText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter description';
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    _save();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFCAF4DD),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.black,fontSize: 20
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() {
    // Check if the form fields are valid
    if (_formField.currentState!.validate()) {
      // If validation succeeds, add the task
      Navigator.of(context).pop(Todo(
        title: _titleController.text,
        description: _descriptionController.text,
        completed:
        widget.item.completed, // Pass the existing value of completed
      ));
      showToast(
        'Task saved successfully', // Message to display
        context: context,
        animation: StyledToastAnimation.fade,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.bottom,
        duration: Duration(seconds: 2),
        animDuration: Duration(milliseconds: 250),
        curve: Curves.easeOut,
        reverseCurve: Curves.easeOut,
        backgroundColor: Color(0xFFCAF4DD),
        // Background color
        textStyle: TextStyle(color: Colors.black), // Text style
      );
    }
  }
}
