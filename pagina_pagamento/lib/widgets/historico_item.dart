import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HistoricoItem extends StatelessWidget {
  final String titulo;
  final String valor;
  final String data;
  final bool liberado;
  final VoidCallback? onTap;

  const HistoricoItem({
    super.key,
    required this.titulo,
    required this.valor,
    required this.data,
    required this.liberado,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.lock_outline,
                color: AppColors.primary, size: 30),
            title: Text(
              titulo,
              style: TextStyle(
                color: liberado
                    ? AppColors.primary
                    : AppColors.primaryLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(valor, style: const TextStyle(fontSize: 16)),
                Text(data, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          if (liberado)
            InkWell(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Text(
                  'Sacar agora',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
