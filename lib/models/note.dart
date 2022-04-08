class Note {
  late final String id;
  late final int creation;
  late final int updation;
  static const String type = 'note';
  late final String title;
  late final String body;

  Note({
    this.id = "",
    required this.creation,
    required this.updation,
    required this.title,
    required this.body,
  });

  toMap() {
    return {
      'id': id,
      'creation': creation,
      'updation': updation,
      'type': type,
      'title': title,
      'body': body
    };
  }

  toStr() {
    return "ID: $id Creation: $creation, Updation: $updation\nTitle: $title\nBody: $body";
  }
}
