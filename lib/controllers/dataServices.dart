// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/todoList.dart';

Future<void> addDoc(data) async {
  const String collectionName = "storage/users/";
  await FirebaseFirestore.instance.collection(collectionName).add(data);
}

Future<void> updateDoc(id, dataToChange) async {
  // nesting objects are also supported: "'a.b.c': 'z'"
  const String collectionName = "storage/users";
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .update(dataToChange)
      .then((value) => print("Changed"))
      .catchError((error) => print("Failed to update: $error"));
}

Future<TodoList> readDoc(id) async {
  const String collectionName = "storage/users";
  var doc = await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .get()
      .catchError((e) => print("Caught error: $e"));

  TodoList list = TodoList(
    creation:
        DateTime.fromMillisecondsSinceEpoch(doc['creation'].seconds * 1000),
    updation:
        DateTime.fromMillisecondsSinceEpoch(doc['updation'].seconds * 1000),
    type: doc['type'],
    title: doc['title'],
    list: doc['list'],
  );

  return list;
}

Future<void> deleteDoc(id) async {
  const String collectionName = "storage/users";
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .delete()
      .catchError((e) => print("Caught error: $e"));
}
