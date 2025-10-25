import 'dart:convert';

import 'package:camarim_backend/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppointmentService {
  final url = Uri.parse("http://192.168.15.69:3000/appointments");

  Future<Response?> getAppointmentsByProfessionalId(String id) async {
    try {
      return await http.get(Uri.parse("$url/professional/$id"));
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

  Future<Response?> updateAppointmentStatus(String id, AppointmentStatus status) async {
    try {
      final response = await http.patch(
        Uri.parse("$url/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': statusText(status),
        }),
      );

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

  String statusText(AppointmentStatus? s) {
    switch (s) {
      case AppointmentStatus.COMPLETED:
        return 'COMPLETED';
      case AppointmentStatus.CANCELED:
        return 'CANCELED';
      case AppointmentStatus.SCHEDULED:
        return 'SCHEDULED';
      default:
        return '';
    }
  }
}
