import 'dart:convert';

import 'package:camarim_backend/models/appointment.dart';
import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/services/appointment.service.dart';
import 'package:camarim_backend/widgets/professional_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:camarim_backend/widgets/prof_appointment_card.dart';

class ProfHorariosPage extends StatefulWidget {
  final String professionalId;
  const ProfHorariosPage(this.professionalId, {super.key});

  @override
  State<ProfHorariosPage> createState() => _ProfHorariosPageState();
}

class _ProfHorariosPageState extends State<ProfHorariosPage> {
  @override
  void initState() {
    super.initState();
    _loadProfessional();
  }

  List<Appointment>? appointments;
  List<Appointment>? upcomingAppointments;
  List<Appointment>? pastAppointments;


  Future<void> _loadProfessional() async {
    final service = AppointmentService();
    final result = await service.getAppointmentsByProfessionalId(widget.professionalId);
    if (result != null) {
      final data = jsonDecode(result.body);

      setState(() {
        appointments = (data as List)
              .map((item) => Appointment.fromJson(item))
              .toList();


        if (appointments != null && appointments!.isNotEmpty) {
          for (var appointment in appointments!) {
            if (appointment.startsAt!.isAfter(DateTime.now()) ) {
              upcomingAppointments?.add(appointment);
            }

            if (appointment.endsAt!.isBefore(DateTime.now())) {
              pastAppointments?.add(appointment);
            }
          }
        }
      });
    }
  }

  void _updateAppointmentStatus(String appointmentId, String newStatus) {
    setState(() {
      final index = upcomingAppointments?.indexWhere((item) => item.id == appointmentId);

      if (index != -1) {
        upcomingAppointments[index]['status'] = newStatus;

        if (newStatus == "Concluído" || newStatus == "Não Compareceu") {
          final completedAppointment = upcomingAppointments.removeAt(index);
          historyAppointments.insert(0, completedAppointment);
        }
      }
    });
  }

  void _showActionDialog(BuildContext context, String appointmentId, String currentStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ações do Horário"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentStatus != "Confirmado")
                ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                  title: const Text("Confirmar Horário"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _updateAppointmentStatus(appointmentId, "Confirmado");
                  },
                ),
              ListTile(
                leading: const Icon(Icons.done_all, color: Colors.blue),
                title: const Text("Marcar como Concluído"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateAppointmentStatus(appointmentId, "Concluído");
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel_outlined, color: Colors.red),
                title: const Text("Marcar como 'Não Compareceu'"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateAppointmentStatus(appointmentId, "Não Compareceu");
                },
              ),  ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
@override
Widget build(BuildContext context) {

  return Scaffold(
    backgroundColor: const Color(0xFFF7F7F7), 
    appBar: AppBar(
      title: Image.asset(
        'lib/assets/img/logo.png',
        height: 40,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), 
      elevation: 0,
      centerTitle: true, 
    ),
    body: const _ProfHorariosPageBody(),
    bottomNavigationBar: ProfessionalBottomNavBar(professionalId: widget.professionalId, currentIndex: 0),
    
  );
}

}

class _ProfHorariosPageBody extends StatelessWidget {
  const _ProfHorariosPageBody();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_ProfHorariosPageState>()!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Próximos Horários",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        
        if (state.upcomingAppointments.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Nenhum horário agendado para hoje ou dias seguintes.",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
            ),
          ),

        ...state.upcomingAppointments.map((data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProfAppointmentCard(
              clientName: data['clientName'],
              service: data['service'],
              time: data['time'],
              date: data['date'],
              status: data['status'],
              isHistory: false,
              onTapAction: () => state._showActionDialog(context, data['id'], data['status']),
            ),
          );
        }),

        const SizedBox(height: 32),

        const Text(
          "Histórico de Atendimentos",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),

        ...state.historyAppointments.map((data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ProfAppointmentCard(
              clientName: data['clientName'],
              service: data['service'],
              time: data['time'],
              date: data['date'],
              status: data['status'],
              isHistory: true,
              rating: data['rating'],
              onTapAction: null, 
            ),
          );
        }),
      ],
    );
  }
}