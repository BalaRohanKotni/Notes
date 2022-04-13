// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/todoList.dart';

Future createUserCollection(uid, email, username) async {
  // create user collection
  await FirebaseFirestore.instance
      .collection('users/')
      .doc(uid)
      .set({'email': email, 'username': username});
}

Future<void> addDoc(uid, data) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(data['type'])
      .add(data);
}

Future<void> updateDoc(uid, id, dataToChange, type) async {
  // nesting objects are also supported: "'a.b.c': 'z'"
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(type)
      .doc(id)
      .update(dataToChange)
      .then((value) => print("Changed"))
      .catchError((error) => print("Failed to update: $error"));
}

Future<dynamic> readDoc(uid, id, dType) async {
  var doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(dType)
      .doc(id)
      .get()
      .catchError((e) => print("Caught error: $e"));

  if (dType == 'list') {
    TodoList list = TodoList(
      creation: doc['creation'],
      updation: doc['updation'],
      title: doc['title'],
      list: doc['list'],
    );

    return list;
  } else {
    Note note = Note(
        creation: doc['creation'],
        updation: doc['updation'],
        title: doc['title'],
        body: doc['body']);
    return note;
  }
}

Future<void> deleteDoc(uid, id, type) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(type)
      .doc(id)
      .delete()
      .catchError((e) => print("Caught error: $e"));
}
