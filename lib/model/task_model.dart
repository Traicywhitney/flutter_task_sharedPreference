class Todo {
  String title;
  String description;
  bool completed;

  Todo({
    required this.title,
    required this.description,
    required this.completed,
  });

  Todo.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        description = map['description'] ?? '',
        completed = map['completed'] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
