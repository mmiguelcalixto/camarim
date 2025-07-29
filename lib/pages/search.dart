
import 'package:camarim_backend/pages/professionals.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:camarim_backend/use-cases/search.use-case.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FirestoreService firestoreService = FirestoreService();
  final ProfessionalService professionalService = ProfessionalService();

  final TextEditingController searchController = TextEditingController();

  void clearTexts() {
    searchController.clear();
  }

  String searchInput = "";

  void changeSearchValue() {
    setState(() {
      searchInput = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final searchResult = professionalService.search(searchInput);
    final searchResult = search(searchInput);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Professionals()));
              }, 
              child: Text("Cliente")
            )
          ],
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Pesquisa"),
          TextField(
            controller: searchController,
            onChanged: (value) => setState(() {
              searchInput = searchController.text;
            }),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: searchResult.professionals,
            builder: (context, snapshot) {
              final searchResults = snapshot.data!.docs;

              if (searchResults.isNotEmpty) {
                return Expanded(
                  child: ListView(
                    children: searchResults.map((DocumentSnapshot result){
                      return ListTile(
                        title: Text(result.data().toString()),
                      );
                    }).toList()
                  ),
                );
              } else {
                return Text("");
              }    
            }
          ),
          StreamBuilder<List<DocumentSnapshot>>(
            stream: searchResult.professionalsInService,
            builder: (context, snapshot) {
              final searchResults = snapshot.data;

              if (searchResults != null) {
                return Expanded(
                  child: ListView(
                    children: searchResults.map<Widget>((doc){
                      final data = doc.data();

                      return ListTile(
                        title: Text(data.toString()),
                      );
                    }).toList()
                  ),
                );
              } else {
                return Text("");
              }    
            }
          ),
        ],
      )
    );
  }
}