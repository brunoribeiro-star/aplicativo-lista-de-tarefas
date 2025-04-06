class Todo {
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Todo({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false,
  });
}
