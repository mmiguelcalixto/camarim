import 'package:camarim_backend/models/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
export 'add-service.use-case.dart';

Future<void> addService(String id, Service service) async {
  final CollectionReference professionals = FirebaseFirestore.instance.collection("professionals");
  final CollectionReference services = FirebaseFirestore.instance.collection("services");

  final addedService = await services.add(service.getService());

  professionals.doc(id).update({
    "services": FieldValue.arrayUnion([addedService.id]),
  });
}