import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppointmentService {
  final url = Uri.parse("http://192.168.15.69:3000/appointments");

  Future<Response?> getAppointmentsByProfessionalId(String id) async {
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
