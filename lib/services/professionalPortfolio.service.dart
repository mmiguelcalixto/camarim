import 'dart:io';

import 'package:camarim_backend/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ProfessionalPortfolioService {
  final url = Uri.parse("http://192.168.15.69:3000/professionalPortfolio");

  Future<Response?> addImageToPortfolio(String professionalId, File imageFile) async {

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['professionalId'] = professionalId;

      request.files.add(
        await http.MultipartFile.fromPath(
          'portfolioImage',
          imageFile.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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
}
