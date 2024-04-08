import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_task_daily/Screens/task_details_screen.dart';
import 'package:flutter_task_daily/Screens/update_details_screen.dart';
import 'package:flutter_task_daily/model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Todo> list = [];
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // Retrieve data from SharedPreferences
    List<String>? stringList = sharedPreferences.getStringList('list');
    if (stringList != null) {
      list = stringList.map((item) => Todo.fromMap(json.decode(item))).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List',style: TextStyle(fontSize: 20),),
        backgroundColor: Color(0xFFCAF4DD),
      ),
      body: list.isEmpty ? emptyList() : buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to TaskDetailsScreen for adding a new task
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => TaskDetailsScreen(
                      item:
                          Todo(title: '', description: '', completed: false))))
              .then((newItem) {
            if (newItem != null) {
              // Add the new task to the list
              setState(() {
                list.add(newItem);
                saveData(); // Save data after adding new task
              });
            }
          });
        },
        child: Icon(Icons.add,),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListTile(list[index], index);
      },
    );
  }

  Widget buildListTile(Todo item, int index) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () => changeItemCompleteness(item),
        onLongPress: () => goToEditItemView(item),
        title: Text(
          item.title,
          style: TextStyle(
            color: item.completed ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text(
          item.description,
          style: TextStyle(
            color: item.completed ? Colors.grey : Colors.black,
          ),
        ),
        trailing: Icon(
          item.completed ? Icons.check_box : Icons.check_box_outline_blank,
          key: Key('completed-icon-$index'),
        ),
      ),
    );
  }

  void goToEditItemView(Todo item) async {
    final updatedItem =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UpdateDetailsScreen(item: item, onDelete: _deleteItem);
    }));

    if (updatedItem != null) {
      setState(() {
        int index = list.indexWhere((element) => element == item);
        if (index != -1) {
          list[index] = updatedItem;
          saveData(); // Save updated data
        }
      });
    }
  }

  void _deleteItem(Todo item) {
    setState(() {
      list.remove(item); // Remove the item from the list
      saveData(); // Save the updated list to SharedPreferences
    });
  }

  void editItem(Todo item, String title) {
    item.title = title;
    saveData();
  }

  Widget emptyList() {
    return Center(
      child: Text('No items'),
    );
  }

  Future<void> changeItemCompleteness(Todo item) async {
    setState(() {
      item.completed = !item.completed;
    });
    saveData();
  }

  void saveData() {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }
}
