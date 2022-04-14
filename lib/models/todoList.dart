class TodoList {
  late final String id;
  late final int creation;
  late final int updation;
  static const String type = 'todo-list';
  late final String title;
  late final List<dynamic> list;

  TodoList({
    this.id = "",
    required this.creation,
    required this.updation,
    required this.title,
    required this.list,
  });

  toMap() {
    return {
      'creation': creation,
      'updation': updation,
      'type': type,
      'title': title,
      'body': list,
    };
  }
}
