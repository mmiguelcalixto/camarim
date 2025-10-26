import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camarim_backend/widgets/appointment_card.dart';
import 'package:camarim_backend/models/appointment.dart';
import 'package:camarim_backend/services/appointment.service.dart';

class HorariosPage extends StatefulWidget {
  const HorariosPage({super.key});

  @override
  State<HorariosPage> createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {
  final AppointmentService _appointmentService = AppointmentService();
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    setState(() {
      _appointmentsFuture = _fetchCustomerAppointments();
    });
  }

  Future<List<Appointment>> _fetchCustomerAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final customerId = prefs.getString('customerId');
    if (customerId == null) {
      throw Exception('Usuário não encontrado. Faça o login novamente.');
    }
    return await _appointmentService.getCustomerAppointments(customerId);
  }

  Future<void> _cancelAppointment(String appointmentId) async {
    try {
      final success = await _appointmentService.updateAppointmentStatus(appointmentId, 'CANCELLED');
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Agendamento cancelado com sucesso!'), backgroundColor: Colors.green),
        );
        _loadAppointments(); 
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cancelar: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _rateProfessional(String professionalId, double rating) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getString('customerId');
      if (customerId == null) throw Exception("Cliente não logado");

      final success = await _appointmentService.rateProfessional(professionalId, customerId, rating);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avaliação enviada com sucesso!'), backgroundColor: Colors.green),
        );
         _loadAppointments();
      }
    } catch (e) {
       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao avaliar: ${e.toString()}'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showRatingDialog(BuildContext context, Appointment appointment) {
    double currentRating = 0.0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: Text("Avaliar ${appointment.professionalName}"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < currentRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setModalState(() {
                        currentRating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Fechar"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: const Text("Salvar"),
                  onPressed: () {
                    if (currentRating > 0) {
                       Navigator.of(context).pop();
                       _rateProfessional(appointment.professionalId.toString(), currentRating);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: FutureBuilder<List<Appointment>>(
          future: _appointmentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar horários: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Nenhum horário agendado.", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)));
            }

            final now = DateTime.now();
            final data = snapshot.data ?? <Appointment>[];
            final upcoming = data.where((a) => a.startsAt != null && a.startsAt!.isAfter(now) && a.status != 'CANCELLED').toList();
            final history = data.where((a) => a.startsAt != null && (a.startsAt!.isBefore(now) || a.status == 'CANCELLED')).toList();

            upcoming.sort((a,b) => a.startsAt!.compareTo(b.startsAt!));
            history.sort((a, b) => b.startsAt!.compareTo(a.startsAt!));

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(height: 30, child: Image.asset("lib/assets/img/logo.png")),
                const SizedBox(height: 16),
                
                if (upcoming.isNotEmpty) ...[
                  const Text("Meus Horários", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...upcoming.map((appointment) {
                    return AppointmentCard(
                      name: appointment.professionalName.toString(),
                      time: "${DateFormat('HH:mm').format(appointment.startsAt!.toLocal())}hs",
                      date: DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(appointment.startsAt!.toLocal()),
                      onCancel: () => _cancelAppointment(appointment.id.toString()),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                ],

                const Text("Meu Histórico", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                
                if (history.isEmpty)
                  const Text("Seu histórico de agendamentos aparecerá aqui.", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54))
                else
                  ...history.map((appointment) {
                    return AppointmentCard(
                      name: appointment.professionalName.toString(),
                      time: "${DateFormat('HH:mm').format(appointment.startsAt!.toLocal())}hs",
                      date: DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(appointment.startsAt!.toLocal()),
                      isHistory: true,
                      isCancelled: appointment.status == 'CANCELLED',
                      onRate: () => _showRatingDialog(context, appointment),
                    );
                  }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}