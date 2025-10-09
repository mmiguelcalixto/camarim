import 'package:flutter/material.dart';
import '../widgets/saldo_card.dart';
import '../widgets/historico_item.dart';
import 'sacar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 const SizedBox(height: 40),

              Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png", 
                    height: 20,
                  ),
                ],
              ),
            
              const SizedBox(height: 20),
              const SaldoCard(),
              const SizedBox(height: 20),
              const Text(
                'Histórico',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const HistoricoItem(
                titulo: 'Aguardando liberação de pagamento',
                valor: 'R\$ 500,00',
                data: '05/10/2025',
                liberado: false,
              ),
              const SizedBox(height: 12),
              HistoricoItem(
                titulo: 'Pagamento liberado',
                valor: 'R\$ 200,00',
                data: '05/10/2025',
                liberado: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SacarPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
