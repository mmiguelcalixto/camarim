import 'dart:convert';

import 'package:camarim_backend/models/appointment.dart';
import 'package:camarim_backend/services/appointment.service.dart';
import 'package:camarim_backend/services/customer.service.dart';
import 'package:camarim_backend/services/service.service.dart';
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
    _loadAppointments();
  }

  List<Appointment> upcomingAppointments = [];
  List<Appointment> pastAppointments = [];
  List<Appointment> appointments = [];

  final appointmentService = AppointmentService();

  Future<void> _loadAppointments() async {
    final result = await appointmentService.getAppointmentsByProfessionalId(widget.professionalId);
    if (result != null) {
      final data = jsonDecode(result.body);

      setState(() {
        appointments = (data as List)
              .map((item) => Appointment.fromJson(item))
              .toList();


        if (appointments.isNotEmpty) {
          for (var appointment in appointments) {
            if (appointment.startsAt != null && appointment.startsAt!.isAfter(DateTime.now())) {
              upcomingAppointments.add(appointment);
            }

            if (appointment.endsAt != null && appointment.endsAt!.isBefore(DateTime.now())) {
              pastAppointments.add(appointment);
            }
          }
        }
      });
    }
  }

  Future<String> getCustomerById(String? id) async {
    if (id == null) return 'Cliente';
    final service = CustomerService();
    final customer = await service.getCustomerProfile(id);

    return customer.fullName;
  }

  Future<String> getServiceById(String? id) async {
    if (id == null) return 'Serviço';
    final service = ServiceService();
    final result = await service.getById(id);

    return result.name;
  }

  Future<void> _updateAppointmentStatus(String appointmentId, AppointmentStatus newStatus) async {
    final index = upcomingAppointments.indexWhere((item) => item.id == appointmentId);

    if (index != -1) {
      final appt = upcomingAppointments[index];
      appt.status = newStatus;

      await appointmentService.updateAppointmentStatus(appointmentId, newStatus);

      setState(() {
        if (newStatus == AppointmentStatus.COMPLETED || newStatus == AppointmentStatus.CANCELED) {
          final completedAppointment = upcomingAppointments.removeAt(index);
          pastAppointments.insert(0, completedAppointment);
        } else {
          upcomingAppointments[index] = appt;
        }
      });
    }
  }


  void _showActionDialog(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final apptIndex = appointments.indexWhere((a) => a.id == appointmentId);
        if (apptIndex == -1) return const SizedBox.shrink();
        final appt = appointments[apptIndex];

        String currentStatus = appt.status?.name ?? AppointmentStatus.SCHEDULED.name;

        return AlertDialog(
          title: const Text("Ações do Horário"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentStatus != AppointmentStatus.SCHEDULED.name)
                ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                  title: const Text("Confirmar Horário"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _updateAppointmentStatus(appointmentId, AppointmentStatus.SCHEDULED);
                  },
                ),
              ListTile(
                leading: const Icon(Icons.done_all, color: Colors.blue),
                title: const Text("Marcar como Concluído"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateAppointmentStatus(appointmentId, AppointmentStatus.COMPLETED);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel_outlined, color: Colors.red),
                title: const Text("Cancelar"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateAppointmentStatus(appointmentId, AppointmentStatus.CANCELED);
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
    body: _ProfHorariosPageBody(),
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
        
        if (state.upcomingAppointments.isEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Nenhum horário agendado para hoje ou dias seguintes.",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
            ),
          ),
        ] else ...state.upcomingAppointments.map((appt) {
          String formatTime(DateTime? dt) {
            if (dt == null) return "--:--";
            final h = dt.hour.toString().padLeft(2, '0');
            final m = dt.minute.toString().padLeft(2, '0');
            return "$h:$m";
          }

          String formatDate(DateTime? dt) {
            if (dt == null) return "--/--/----";
            return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
          }

          String statusText(AppointmentStatus? s) {
            switch (s) {
              case AppointmentStatus.COMPLETED:
                return 'Concluído';
              case AppointmentStatus.CANCELED:
                return 'Cancelado';
              case AppointmentStatus.SCHEDULED:
                return 'Marcado';
              default:
                return '';
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FutureBuilder<String>(
              future: state.getCustomerById(appt.customerId),
              builder: (context, customerSnapshot) {
                if (customerSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final clientName = customerSnapshot.data ?? 'Cliente';

                return FutureBuilder<String>(
                  future: state.getServiceById(appt.serviceId),
                  builder: (context, serviceSnapshot) {
                    if (serviceSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final serviceName = serviceSnapshot.data ?? 'Serviço';

                    return ProfAppointmentCard(
                      clientName: clientName,
                      service: serviceName,
                      time: formatTime(appt.startsAt),
                      date: formatDate(appt.startsAt),
                      status: statusText(appt.status),
                      isHistory: false,
                      onTapAction: appt.id != null
                          ? () => state._showActionDialog(context, appt.id!)
                          : null,
                    );
                  },
                );
              },
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

        ...state.pastAppointments.map((appt) {
          String formatTime(DateTime? dt) {
            if (dt == null) return "--:--";
            final h = dt.hour.toString().padLeft(2, '0');
            final m = dt.minute.toString().padLeft(2, '0');
            return "$h:$m";
          }

          String formatDate(DateTime? dt) {
            if (dt == null) return "--/--/----";
            return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
          }

          String statusText(AppointmentStatus? s) {
            switch (s) {
              case AppointmentStatus.COMPLETED:
                return 'Concluído';
              case AppointmentStatus.CANCELED:
                return 'Cancelado';
              case AppointmentStatus.SCHEDULED:
                return 'Agendado';
              default:
                return '';
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FutureBuilder<String>(
              future: state.getCustomerById(appt.customerId),
              builder: (context, customerSnapshot) {
                final clientName = customerSnapshot.data ?? 'Cliente';
                return FutureBuilder<String>(
                  future: state.getServiceById(appt.serviceId),
                  builder: (context, serviceSnapshot) {
                    final serviceName = serviceSnapshot.data ?? 'Serviço';
                    return ProfAppointmentCard(
                      clientName: clientName,
                      service: serviceName,
                      time: formatTime(appt.startsAt),
                      date: formatDate(appt.startsAt),
                      status: statusText(appt.status),
                      isHistory: true,
                      rating: null,
                      onTapAction: null, 
                    );
                  },
                );
              },
            ),
          );
        }),
      ],
    );
  }
}