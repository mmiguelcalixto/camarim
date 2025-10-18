import 'dart:io';

import 'package:camarim_backend/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfessionalService {
  final url = Uri.parse("http://192.168.15.69:3000/professionals");

  Future<Response?> createProfessional(Professional professional, File imageFile) async {

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['name'] = professional.name;
      request.fields['document'] = professional.document;
      request.fields['email'] = professional.email;
      request.fields['phone'] = professional.phone;
      request.fields['password'] = professional.password!;
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

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 409 && response.body == "Email already exists") {
        Fluttertoast.showToast(
          msg: "Esse email já existe.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }

      if (response.statusCode == 409 && response.body == "Document already exists") {
        Fluttertoast.showToast(
          msg: "Esse documento já existe.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
  
      return response;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocorreu um erro",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      return null;
    }
  }

  Future<Response?> getProfessionalById(String id) async {
    try {
      return await http.get(Uri.parse("$url/$id"));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocorreu um erro",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );

      return null;
    }
  }
}
