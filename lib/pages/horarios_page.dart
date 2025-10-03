import 'package:flutter/material.dart';
import '../widgets/appointment_card.dart';

class HorariosPage extends StatefulWidget {
  const HorariosPage({super.key});

  @override
  State<HorariosPage> createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {

  List<Map<String, dynamic>> upcomingAppointments = [
    {
      "id": 1,
      "name": "Giovanna Hair",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de setembro",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false,
    },
     {
      "id": 1,
      "name": "Giovanna Hair",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de setembro",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false,
    },
  ];

  List<Map<String, dynamic>> historyAppointments = [
    {
      "id": 2,
      "name": "Giovanna",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de Abril",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false, 
    },
    {
      "id": 3,
      "name": "Giovanna",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de Abril",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false,
    },
    {
      "id": 4,
      "name": "Giovanna",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de Abril",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false,
    },
  ];

  void _cancelAppointment(int appointmentId) {
    setState(() {
      final index = upcomingAppointments.indexWhere((item) => item['id'] == appointmentId);

      if (index != -1) {
        final cancelledAppointment = upcomingAppointments.removeAt(index);
        
        cancelledAppointment['isCancelled'] = true;

        historyAppointments.insert(0, cancelledAppointment);
      }
    });
  }

  void _showCancelDialog(BuildContext context, int appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancelar Horário"),
          content: const Text("Tem certeza que deseja cancelar este horário?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar", style: TextStyle(color: Colors.black54)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirmar Cancelamento", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(); 
                _cancelAppointment(appointmentId); 
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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 30,
              child: Container(
                color: const Color(0xFFF7F7F7),
                child: Image.asset("lib/assets/img/logo.png"),
              ),
            ),
            const SizedBox(height: 16),

            RichText(
              text: TextSpan(
                text: "Meus Horários",
                style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            ...upcomingAppointments.map((data) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppointmentCard(
                  name: data['name'],
                  time: data['time'],
                  date: data['date'],
                  imageUrl: data['imageUrl'],
                  isHistory: false,
                  isCancelled: data['isCancelled'], 
                  onCancel: () => _showCancelDialog(context, data['id']),
                ),
              );
            }).toList(),
            
            if (upcomingAppointments.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "Nenhum horário agendado",
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
                ),
              ),

            const SizedBox(height: 24),

            RichText(
              text: TextSpan(
                text: "Meu Histórico ",
                style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Column(
              children: historyAppointments.map((data) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppointmentCard(
                    name: data['name'],
                    time: data['time'],
                    date: data['date'],
                    imageUrl: data['imageUrl'],
                    isHistory: true,
                    isCancelled: data['isCancelled'], 
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}