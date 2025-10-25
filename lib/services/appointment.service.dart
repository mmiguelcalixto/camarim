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
  // get professional times busca os horarios disponiveis do profissional
  Future<List<ProfessionalTimeSlot>> getProfessionalTimes(String professionalId, DateTime date) async {
    final dateString =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final url = Uri.parse('$_baseUrl/professionalTimes/professional/$professionalId?date=$dateString');
    print('Tentando acessar a URL ${url.toString()}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ProfessionalTimeSlot.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar horários. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getProfessionalTimes: $e');
      throw Exception('Não foi possível buscar os horários. Verifique o CORS ou a conexão com o servidor.');
    }
  }

  // agendar um horario
  Future<bool> scheduleTime(ScheduleTimeRequest request) async {
    final url = Uri.parse('$_baseUrl/professionalTimes/schedule');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      String errorMessage = "Não foi possível realizar o agendamento.";
      try {
        final errorJson = jsonDecode(response.body);
        if (errorJson['message'] != null) {
          errorMessage = errorJson['message'];
        }
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }

  // busca agendamentos do cliente
  Future<List<Appointment>> getCustomerAppointments(String customerId) async {
final url = Uri.parse('$_baseUrl/appointments/customer/$customerId');
    print('DEBUG: Chamando $url');

    try {
      final response = await http.get(url);
      print('DEBUG: Resposta -> ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final professionalService = ProfessionalService();

        List<Appointment> appointments = [];

        for (var item in data) {
          final appointment = Appointment.fromJson(item);

          try {
            final professional =
                await professionalService.getProfessionalById(appointment.professionalId);
            appointment.professionalName = professional?.name ?? "Profissional não encontrado";
          } catch (e) {
            print('Erro ao buscar profissional ${appointment.professionalId}: $e');
            appointment.professionalName = "Profissional não encontrado";
          }

          appointments.add(appointment);
        }

        return appointments;
      } else {
        throw Exception('Erro ao carregar agendamentos: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getCustomerAppointments: $e');
      throw Exception('Não foi possível buscar os agendamentos');
    }
  }

  // rate professional
  Future<bool> rateProfessional(String professionalId, String customerId, double rating) async {
    final url = Uri.parse('$_baseUrl/professionalRatings');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'professionalId': professionalId,
        'customerId': customerId,
        'rating': rating,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Falha ao enviar avaliação: ${response.body}');
    }
  }

  // atualiza o status do appointment
  Future<bool> updateAppointmentStatus(String appointmentId, String status) async {
    final url = Uri.parse('$_baseUrl/appointments/$appointmentId');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Falha ao atualizar status do agendamento: ${response.body}');
    }
  }
}
