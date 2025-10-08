import 'package:flutter/material.dart';

class ProfAppointmentCard extends StatelessWidget {
  final String clientName;
  final String service;
  final String time;
  final String date;
  final String status;
  final bool isHistory;
  final double? rating;
  final VoidCallback? onTapAction;

  const ProfAppointmentCard({
    super.key,
    required this.clientName,
    required this.service,
    required this.time,
    required this.date,
    required this.status,
    this.isHistory = false,
    this.rating,
    this.onTapAction,
  });

  Color _getStatusColor() {
    switch (status) {
      case "Confirmado":
        return Colors.green;
      case "Agendado":
        return Colors.orange;
      case "Cancelado":
      case "Não Compareceu":
        return Colors.red;
      case "Concluído":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: isHistory ? null : onTapAction, 
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(),
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              
              Text(
                clientName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                service,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              
              if (isHistory && (rating ?? 0) > 0) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      "Avaliação do cliente: ${rating!.toStringAsFixed(1)}",
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ],

              if (!isHistory) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onTapAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9FA0E4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Gerenciar Horário"),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
