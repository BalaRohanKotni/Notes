class TodoList {
  late final String id;
  late final DateTime creation;
  late final DateTime updation;
  late final String type;
  late final String title;
  late final List<dynamic> list;

  TodoList({
    this.id = "",
    required this.creation,
    required this.updation,
    required this.type,
    required this.title,
    required this.list,
  });

  toMap() {
    return {
      'creation': creation.millisecondsSinceEpoch,
      'updation': updation.millisecondsSinceEpoch,
      'type': type,
      'title': title,
      'list': list,
    };
  }

  toStr() {
    var listOfTodoStr = "";
    for (var item in list) {
      item['true'] != null
          ? listOfTodoStr += "true: ${item['true']}\n"
          : "nope";
      item['false'] != null
          ? listOfTodoStr += "false: ${item['false']}\n"
          : "nope";
    }

    print(creation.isUtc);
    return "ID: $id Creation: $creation, Updation: $updation\nTitle: $title\nTODOS:\n$listOfTodoStr";
  }
}
