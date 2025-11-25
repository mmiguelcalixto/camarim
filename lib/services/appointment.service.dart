import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';
import '../models/professional.dart';
import '../models/professional_time_slot.dart';
import '../models/schedule_time.dart';
import './professional.service.dart';

class AppointmentService {
  final String _baseUrl = "https://camarim-api.onrender.com"; 

// METODOS PROFESSIONAL - MIGUEL ________________________________________________________________________________________________________
  /// nisca todos os agendamentos de um profissional
  Future<List<Appointment>> getAppointmentsByProfessionalId(String professionalId) async {
    final url = Uri.parse('$_baseUrl/appointments/professional/$professionalId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Appointment.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao buscar agendamentos do profissional');
      }
    } catch (e) {
      print('Erro em getAppointmentsByProfessionalId: $e');
      throw Exception('Erro de conexão ao buscar agendamentos.');
    }
  }

// METODOS CUSTOMER - LAURA ________________________________________________________________________________________________________

  /// busca os horarios disponiveis de um profissional
  Future<List<ProfessionalTimeSlot>> getProfessionalTimes(String professionalId, DateTime date) async {
    final dateString = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final url = Uri.parse('$_baseUrl/professionalTimes/professional/$professionalId?date=$dateString');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ProfessionalTimeSlot.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar horários. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Não foi possível buscar os horários. Verifique a conexão com o servidor.');
    }
  }

  /// agenda um horário p um cliente
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
      throw Exception('Não foi possível realizar o agendamento: ${response.body}');
    }
  }

  /// busca todos os agendamentos de um cliente
  Future<List<Appointment>> getCustomerAppointments(String customerId) async {
    final url = Uri.parse('$_baseUrl/appointments/customer/$customerId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final professionalService = ProfessionalService();
        List<Appointment> appointments = [];
        for (var item in data) {
          final appointment = Appointment.fromJson(item);
          try {
            final professional = await professionalService.getProfessionalById(appointment.professionalId.toString());
            appointment.professionalName = professional?.name ?? "Não encontrado";
          } catch (e) {
            appointment.professionalName = "Não encontrado";
          }
          appointments.add(appointment);
        }
        return appointments;
      } else {
        throw Exception('Erro ao carregar agendamentos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Não foi possível buscar os agendamentos.');
    }
  }

  /// avaliar profissional 
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
    return response.statusCode == 201 || response.statusCode == 200;
  }

  /// att statsus agendamento
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
      throw Exception('Falha ao atualizar status: ${response.body}');
    }
  }

//get professional by id
  Future<Professional?> getProfessionalById(String id) async {
  final url = Uri.parse('$_baseUrl/professionals/$id');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Professional.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e) {
    print('Erro ao buscar profissional por ID: $e');
    return null;
  }
}
}