class TodoList {
  late final String id;
  late final DateTime creation;
  late final DateTime updation;
  late final String type;
  late final String title;
  late final List<Map> list;

  TodoList({
    this.id = "",
    required this.creation,
    required this.updation,
    required this.type,
    required this.title,
    required this.list,
  });
}
