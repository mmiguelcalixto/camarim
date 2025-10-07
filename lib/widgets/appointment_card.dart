import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String time;
  final String date;
  final String imageUrl;
  final bool isHistory;
  final bool isCancelled;
  final VoidCallback? onCancel;
  final double rating;
  final VoidCallback? onRate;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.time,
    required this.date,
    required this.imageUrl,
    this.isHistory = false,
    this.isCancelled = false,
    this.rating = 0.0, 
    this.onCancel,
    this.onRate, 
  });

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Cancelar Agendamento",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                if (onCancel != null) {
                  onCancel!();
                }
              },
              child: const Text(
                "Sim, cancelar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isHistory && isCancelled)
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Agendamento cancelado pelo cliente",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
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
                        const SizedBox(height: 4),
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
                                  color: isCancelled
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 177, 221, 179),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isCancelled ? "Cancelado" : "Concluído",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            : ElevatedButton(
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
                  ),
                ),

                if (isHistory && !isCancelled)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (rating > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              Text(
                                rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.amber,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ],
                          ),
                        ),

                      if (onRate != null)
                        IconButton(
                          icon: Icon(
                            rating > 0 ? Icons.star : Icons.star_border,
                            color: rating > 0 ? Colors.amber : Colors.grey,
                            size: 32,
                          ),
                          onPressed: onRate, 
                        )
                      else if (rating == 0.0)
                         const Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 8.0),
                          child: Text(
                            "Avalie!",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}