
import 'package:camarim_backend/models/service.dart';
import 'package:camarim_backend/pages/professionals.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:camarim_backend/services/firestore.service.dart';
import 'package:camarim_backend/use-cases/search.use-case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:camarim_backend/use-cases/filter-by-service-type.use-case.dart';

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

  String dropDownValue = "cabelo";
  Stream<List<DocumentSnapshot<Object?>>>? filteredTypes;

  @override
  Widget build(BuildContext context) {
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
          DropdownButton(
            items: const [
              DropdownMenuItem(value: "cabelo", child: Text("Cabelo")),
              DropdownMenuItem(value: "manicure", child: Text("Manicure")),
              DropdownMenuItem(value: "pedicure", child: Text("Pedicure")),
              DropdownMenuItem(value: "maquiagem", child: Text("Maquiagem")),
              DropdownMenuItem(value: "estetica", child: Text("Estética")),
            ],
            value: dropDownValue,
            onChanged: (String? newValue) {
              setState(() {
                filteredTypes = null;
                
                dropDownValue = newValue!;

                ServiceType serviceType;

                switch (dropDownValue) {
                  case "cabelo":
                    serviceType = ServiceType.cabelo;
                    break;
                  case "manicure":
                    serviceType = ServiceType.manicure;
                    break;
                  case "pedicure":
                    serviceType = ServiceType.pedicure;
                    break;
                  case "maquiagem":
                    serviceType = ServiceType.maquiagem;
                    break;
                  case "estetica":
                    serviceType = ServiceType.estetica;
                  default:
                    throw Exception("Invalid service servicetype");
                }

                filteredTypes = filterByServiceType(serviceType);
              });
            }
          ),
          StreamBuilder<QuerySnapshot>(
            stream: searchResult.professionals,
            builder: (context, snapshot) {
              final searchResults = snapshot.data!.docs;

              if (searchResults.isNotEmpty && filteredTypes == null) {
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

              if (searchResults != null && filteredTypes == null) {
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
          StreamBuilder<List<DocumentSnapshot>>(
            stream: filteredTypes,
            builder: (context, snapshot) {
              final results = snapshot.data;

              if (results != null) {
                return Expanded(
                  child: ListView(
                    children: results.map<Widget>((doc){
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