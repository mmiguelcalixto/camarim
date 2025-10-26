import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginService {
  final url = Uri.parse("http://localhost:3000");

  Future<Response?> login(String email, String password) async {
    try {
        final response = await http.post(
          Uri.parse("$url/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          }),
        );

      if (response.statusCode == 401 || response.statusCode == 404) {
        Fluttertoast.showToast(
          msg: "Email ou senha incorretos.",
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

  Future<Response?> logout() async {
    try {
      final response = await http.post(
        Uri.parse("$url/logout"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
}
