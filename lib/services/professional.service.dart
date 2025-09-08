import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalService {
  final FirestoreService firestoreService =
      FirestoreService(FirebaseFirestore.instance.collection("professionals"));

  Future<void> addProfessional(Professional professional) async {
    final createdProfessional =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: professional.email.trim(),
      password: professional.password.trim(),
    );

    await firestoreService.add(
      createdProfessional.user!.uid,
      professional.getProfessional(),
    );
  }

  Future<void> updateProfessional(String id, Professional data) async {
    await firestoreService.update(id, {
      "name": data.name,
      "document": data.document,
      "email": data.email,
      "phone": data.phone,
      "password": data.password,
    });
  }

  Future<Map<String, dynamic>?> getProfessionalById(String id) async {
    return await firestoreService.getById(id);
  }

  Stream<List<Map<String, dynamic>>> getAllProfessionals() {
    return firestoreService.getAll();
  }

  Future<void> deleteProfessional(String id) async {
    await firestoreService.delete(id);
  }
}
