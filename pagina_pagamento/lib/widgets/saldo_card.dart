import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.person, color: Colors.white),
              SizedBox(width: 8),
              Text(
                '@username',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.star, color: Colors.white),
              SizedBox(width: 4),
              Text(
                '4.5',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Saldo disponível',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Text(
            'R\$ 0,00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Total a receber: R\$ 0,00',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
