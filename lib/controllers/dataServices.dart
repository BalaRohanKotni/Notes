// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addDoc(id, data) async {
  const String collectionName = "storage";
  await FirebaseFirestore.instance.collection(collectionName).doc(id).set(data);
}

Future<void> updateDoc(id, dataToChange) async {
  // nesting objects are also supported: "'a.b.c': 'z'"
  const String collectionName = "storage";
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .update(dataToChange)
      .then((value) => print("Changed"))
      .catchError((error) => print("Failed to update: $error"));
}

Future<dynamic> readDoc(id) async {
  const String collectionName = "storage";
  return await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .get()
      .catchError((e) => print("Caught error: $e"));
}

Future<void> deleteDoc(id) async {
  const String collectionName = "storage";
  await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(id)
      .delete()
      .catchError((e) => print("Caught error: $e"));
}
