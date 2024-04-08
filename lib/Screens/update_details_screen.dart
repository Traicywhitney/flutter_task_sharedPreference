import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_task_daily/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDetailsScreen extends StatefulWidget {
  final Todo item;
  final Function(Todo) onDelete; // Callback function to notify TaskScreen

  UpdateDetailsScreen({required this.item, required this.onDelete});

  @override
  State<UpdateDetailsScreen> createState() => _UpdateDetailsScreenState();
}

class DataUtils {
  static Future<void> saveData(List<Todo> list) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    await sharedPreferences.setStringList('list', stringList);
  }
}

class _UpdateDetailsScreenState extends State<UpdateDetailsScreen> {
  final _formField = GlobalKey<FormState>();
  List<Todo> list = [];
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();

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
        title: Text('Update Details screen'),
        backgroundColor: Color(0xFFCAF4DD),
        actions: [
          IconButton(
            onPressed: () {
              print('------->delete icon pressed');
              _deleteFormDialog(context);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formField,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                    _update();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFCAF4DD),
                    ),
                  ),
                  child: Text('Update',style: TextStyle(color: Colors.black,fontSize: 20),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteFormDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                print('--------------> Delete Button Clicked');
                _deleteItem(widget.item); // Pass the item to delete
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            )
          ],
          title: const Text('Are you sure you want to delete this?'),
        );
      },
    );
  }

  void _update() {
    if (_formField.currentState!.validate()) {
      // If validation succeeds, add the task
      Navigator.of(context).pop(Todo(
        title: _titleController.text,
        description: _descriptionController.text,
        completed:
            widget.item.completed, // Pass the existing value of completed
      ));
      showToast(
        'Task Updated  successfully', // Message to display
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

  void _deleteItem(Todo item) async {
    // Remove the item from the list
    list.remove(item);

    // Save the updated list to SharedPreferences
    await DataUtils.saveData(list);
    widget.onDelete(widget.item);
    Navigator.pop(context);
    // Show success snackbar
    showToast(
      'Task Updated  successfully', // Message to display
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
