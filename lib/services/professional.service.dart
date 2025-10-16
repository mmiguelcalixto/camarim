import 'dart:convert';
import 'dart:io';

import 'package:camarim_backend/models/professional.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfessionalService {
  final url = Uri.parse("http://192.168.15.69:3000/professionals");

  Future<StreamedResponse> createProfessional(Professional professional, File imageFile) async {
    var request = http.MultipartRequest('POST', url);


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
}
