import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfessionalService {
  final FirestoreService firestoreService = FirestoreService();
  final CollectionReference professionals = FirebaseFirestore.instance.collection("professionals");
  final CollectionReference services = FirebaseFirestore.instance.collection("services");

  Future<void> addProfessional(Professional professional) async {
    final createdProfessional = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: professional.email.trim(), 
      password: professional.password.trim(),
    );

    professionals.doc(createdProfessional.user!.uid).set(professional.getProfessional());
  }

  Future<void> updateProfessional(String id, Professional data) {
    return professionals.doc(id).update({
      "name": data.name,
      "document": data.document,
      "email": data.email,
      "phone": data.phone,
      "password": data.password,
    });
  }
}
