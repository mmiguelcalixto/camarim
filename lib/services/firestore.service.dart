import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/professional.dart';
import 'firestore.service.dart';


class FirestoreService {
  final CollectionReference collection;

  FirestoreService(this.collection);

  Future<void> add(String id, Map<String, dynamic> data) async {
    await collection.doc(id).set(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await collection.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }

  Future<Map<String, dynamic>?> getById(String id) async {
    final doc = await collection.doc(id).get();
    return doc.data() as Map<String, dynamic>?;
  }

  Stream<List<Map<String, dynamic>>> getAll() {
    return collection.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList(),
    );
  }
}
