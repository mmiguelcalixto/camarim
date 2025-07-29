import 'package:camarim_backend/models/service.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

export 'package:camarim_backend/use-cases/filter-by-service-type.use-case.dart';

Stream<List<DocumentSnapshot<Object?>>> filterByServiceType(ServiceType serviceType) {
  final FirestoreService firestoreService = FirestoreService();
  final CollectionReference professionals = FirebaseFirestore.instance.collection("professionals");
  final CollectionReference services = FirebaseFirestore.instance.collection("services");

  final filteredSevices = services.orderBy("type").startAt([serviceType.name]).snapshots();

  final professionalsInService = filteredSevices.asyncMap((snapshot) async {
    List<DocumentSnapshot> results = [];

    for (var service in snapshot.docs) {
      final professionalId = service.get("professional");
      final professional = await firestoreService.getById(professionalId, professionals);

      results.add(professional);
    }

    return results;
  });

  return professionalsInService;

}