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
      "id": 5,
      "name": "Giovanna Hair",
      "time": "10:30hs",
      "date": "Terça-feira, 25 de Outubro",
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
      "rating": 0.0, 
    },
    {
      "id": 3,
      "name": "Giovanna",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de Abril",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false,
      "rating": 4.0, 
    },
    {
      "id": 4,
      "name": "Giovanna",
      "time": "14:00hs",
      "date": "Segunda-feira, 17 de Abril",
      "imageUrl": "lib/assets/img/perfil.png",
      "isCancelled": false,
      "rating": 0.0,
    },
  ];

  double _currentRating = 0.0;

  void _cancelAppointment(int appointmentId) {
    setState(() {
      final index = upcomingAppointments.indexWhere((item) => item['id'] == appointmentId);

      if (index != -1) {
        final cancelledAppointment = upcomingAppointments.removeAt(index);
        cancelledAppointment['isCancelled'] = true;
        cancelledAppointment['rating'] = 0.0; 

        historyAppointments.insert(0, cancelledAppointment);
      }
    });
  }

  void _saveRating(int appointmentId, double rating) {
    setState(() {
      final index = historyAppointments.indexWhere((item) => item['id'] == appointmentId);
      if (index != -1) {
        historyAppointments[index]['rating'] = rating;
      }
    });
  }

  void _showRatingDialog(BuildContext context, int appointmentId, String name, double initialRating) {
    _currentRating = initialRating; 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: Text("Avaliar $name"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Avalie a sua experiência:"),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _currentRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          setModalState(() {
                            _currentRating = index + 1.0;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Fechar", style: TextStyle(color: Colors.black54)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text("Salvar Avaliação"),
                  onPressed: () {
                    _saveRating(appointmentId, _currentRating);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
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
    // Retorna o Scaffold, e o corpo é movido para o widget separado
    return const Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: _HorariosPageBody(),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// NOVO WIDGET: Contém a estrutura visual do ListView
// --------------------------------------------------------------------------

class _HorariosPageBody extends StatelessWidget {
  const _HorariosPageBody();

  @override
  Widget build(BuildContext context) {
    // Acessa o estado pai para obter os dados e funções
    final state = context.findAncestorStateOfType<_HorariosPageState>()!;

    return ListView(
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

        ...state.upcomingAppointments.map((data) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppointmentCard(
              name: data['name'],
              time: data['time'],
              date: data['date'],
              imageUrl: data['imageUrl'],
              isHistory: false,
              isCancelled: data['isCancelled'],
              onCancel: () => state._showCancelDialog(context, data['id']), rating: 0.0,
            ),
          );
        }),

        if (state.upcomingAppointments.isEmpty)
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
          children: state.historyAppointments.map((data) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppointmentCard(
                name: data['name'],
                time: data['time'],
                date: data['date'],
                imageUrl: data['imageUrl'],
                isHistory: true,
                isCancelled: data['isCancelled'],
                rating: data['rating'],
                onRate: data['isCancelled'] == false && data['rating'] < 5
                    ? () => state._showRatingDialog(context, data['id'], data['name'], data['rating'])
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}