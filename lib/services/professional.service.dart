import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/professional.dart'; 
import '../models/professional_profile.dart';
import '../models/search_result.dart';
import '../models/search_filter.dart';



class ProfessionalService {
  final String baseUrl = "http://localhost:3000/professionals";

 //get professionals
  Future<List<Professional>> getProfessionals() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Professional.fromJson(json)).toList(); 
    } else {
      throw Exception('Falha ao carregar profissionais');
    }
  }

  //  get professional byid
  Future<ProfessionalProfile> getProfessionalById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProfessionalProfile.fromJson(data);
    } else {
      throw Exception('Falha ao carregar dados do profissional');
    }
  }

  // create professional 
  Future<StreamedResponse> createProfessional(Professional professional, File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    request.fields['name'] = professional.name;
    request.fields['document'] = professional.document;
    request.fields['email'] = professional.email;
    request.fields['phone'] = professional.phone;
    request.fields['password'] = professional.password;
    request.fields['addressStreet'] = professional.addressStreet;
    request.fields['addressNumber'] = professional.addressNumber;
    request.fields['addressNeighborhood'] = professional.addressNeighborhood;
    request.fields['addressCity'] = professional.addressCity;
    request.fields['addressState'] = professional.addressState;
    request.fields['addressCep'] = professional.addressCep;

    request.files.add(
      await http.MultipartFile.fromPath(
        'profileImage',
        imageFile.path,
      ),
    );

    return await request.send();
  }

// search professionals
Future<List<SearchResult>> searchProfessionals({String? query, SearchFilter? filter}) async {
  final filterParams = filter?.toQueryParameters() ?? {};
  
  if (query != null && query.isNotEmpty) {
    filterParams['q'] = query;
  }

  final url = Uri.parse('$baseUrl/search').replace(queryParameters: filterParams);

print('URL DE BUSCA SENDO CHAMADA: $url');


  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => SearchResult.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao buscar profissionais: ${response.body}');
  }
}



}