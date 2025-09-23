import 'package:camarim_backend/models/search_result.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

export 'package:camarim_backend/use-cases/search.use-case.dart';

SearchResult search(String searchInput) {
  final FirestoreService firestoreService = FirestoreService();
  final CollectionReference professionals = FirebaseFirestore.instance.collection("professionals");
  final CollectionReference services = FirebaseFirestore.instance.collection("services");

  final professionalsSearch = professionals.orderBy("name").startAt([searchInput]).endAt(["$searchInput\uf8ff"]).snapshots();
  final servicesSearch = services.orderBy("name").startAt([searchInput]).endAt(["$searchInput\uf8ff"]).snapshots();

  final professionalsInService = servicesSearch.asyncMap((snapshot) async {
    List<DocumentSnapshot> results = [];

    for (var service in snapshot.docs) {
      final professionalId = service.get("professional");
      final professional = await firestoreService.getById(professionalId, professionals);

      results.add(professional);
    }

    return results;
  });

  return SearchResult(professionals: professionalsSearch, professionalsInService: professionalsInService);
}