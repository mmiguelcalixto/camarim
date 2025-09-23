import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class SearchResult {
  Stream<QuerySnapshot<Object?>> professionals;
  Stream<List<DocumentSnapshot>> professionalsInService;
  
  SearchResult({
    required this.professionals,
    required this.professionalsInService,
  });
}