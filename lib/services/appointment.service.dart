import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart'; 
import '../models/professional_time_slot.dart';
import '../models/schedule_time.dart'; 

class AppointmentService {
  final String _baseUrl = "http://localhost:3000";

  // busca os horários disponíveis de um profissional
  Future<List<ProfessionalTimeSlot>> getProfessionalTimes(String professionalId) async {
    final url = Uri.parse('$_baseUrl/professionalTime/professional/$professionalId');

    print('DEBUG: Tentando acessar a URL -> ${url.toString()}');

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
      throw Exception('Não foi possível buscar os horários. Verifique sua conexão.');
    }
  }

  /// agenda um horário (PATCH /professionalTime/schedule)
  Future<bool> scheduleTime(ScheduleTimeRequest request) async {
    final url = Uri.parse('$_baseUrl/professionalTime/schedule');
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

  /// busca os agendamentos de um cliente
  Future<List<Appointment>> getCustomerAppointments(String customerId) async {
    final url = Uri.parse('$_baseUrl/customers/$customerId/appointments');
    print('DEBUG: Tentando acessar a URL -> ${url.toString()}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Appointment.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar seus agendamentos. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro em getCustomerAppointments: $e');
      throw Exception('Não foi possível carregar seus agendamentos. Verifique sua conexão.');
    }
  }

  // avaliar profissional
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

  // atualizar status do agendamento
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
