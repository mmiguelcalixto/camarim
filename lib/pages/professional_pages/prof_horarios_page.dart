import 'package:flutter/material.dart';
import 'package:camarim_backend/widgets/prof_appointment_card.dart';

class ProfHorariosPage extends StatefulWidget {
  const ProfHorariosPage({super.key});

  @override
  State<ProfHorariosPage> createState() => _ProfHorariosPageState();
}

class _ProfHorariosPageState extends State<ProfHorariosPage> {
  List<Map<String, dynamic>> upcomingAppointments = [
    {
      "id": 1,
      "clientName": "Laura Rodrigues", 
      "service": "Manicure",
      "time": "15:00hs",
      "date": "07 de outubro",
      "status": "Agendado", 
    },
    {
      "id": 5,
      "clientName": "Miguel Calixto",
      "service": "Corte Masculino",
      "time": "10:30hs",
      "date": "13 de Outubro",
      "status": "Confirmado",
    },
  ];

  List<Map<String, dynamic>> historyAppointments = [
    {
      "id": 2,
      "clientName": "Caio",
      "service": "Corte Masculino",
      "time": "17:00hs",
      "date": "17 de Abril",
      "status": "Concluído",
      "rating": 5.0,
    },
    {
      "id": 3,
      "clientName": "Natalia",
      "service": "Manicure",
      "time": "14:00hs",
      "date": "17 de Abril",
      "status": "Cancelado",
      "rating": 0.0,
    },
  ];

  void _updateAppointmentStatus(int appointmentId, String newStatus) {
    setState(() {
      final index = upcomingAppointments.indexWhere((item) => item['id'] == appointmentId);

      if (index != -1) {
        upcomingAppointments[index]['status'] = newStatus;

        if (newStatus == "Concluído" || newStatus == "Não Compareceu") {
          final completedAppointment = upcomingAppointments.removeAt(index);
          historyAppointments.insert(0, completedAppointment);
        }
      }
    });
  }

  void _showActionDialog(BuildContext context, int appointmentId, String currentStatus) {
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
        }).toList(),

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
        }).toList(),
      ],
    );
  }
}