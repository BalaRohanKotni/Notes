// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addData(id, data) async {
  const String collectionName = "storage";
  await FirebaseFirestore.instance.collection(collectionName).doc(id).set(data);
}
