import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String time;
  final String date;
  final String imageUrl;
  final bool isHistory;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.time,
    required this.date,
    required this.imageUrl,
    this.isHistory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Lorem ipsum dolor sit amet...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(time),
                  Text(date),
                  const SizedBox(height: 8),

                  isHistory
                      ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 177, 221, 179),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Concluído",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : Row(
                        children: [
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              _showModal(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Cancelar Agendamento",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: const Text(
            "Tem certeza que deseja cancelar o seu agendamento?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Não"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Sim, cancelar",
                style: TextStyle(fontWeight: FontWeight.bold,
                 fontSize: 16, 
                 color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
