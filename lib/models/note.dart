class Note {
  late final String id;
  late final DateTime creation;
  late final DateTime updation;
  late final String type;
  late final String title;
  late final String body;

  Note(
      {this.id = "",
      required this.creation,
      required this.updation,
      required this.type,
      required this.title,
      required this.body});
}
