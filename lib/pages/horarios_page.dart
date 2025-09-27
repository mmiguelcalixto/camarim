import 'package:flutter/material.dart';
import '../widgets/appointment_card.dart';

class HorariosPage extends StatelessWidget {
  const HorariosPage({super.key});

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
            const AppointmentCard(
              name: "Giovanna Hair",
              time: "14:00hs",
              date: "Segunda-feira, 17 de setembro",
              imageUrl: "lib/assets/img/perfil.png",
              isHistory: false,
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
              children: List.generate(3, (index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: AppointmentCard(
                    name: "Giovanna",
                    time: "14:00hs",
                    date: "Segunda-feira, 17 de Abril",
                    imageUrl: "lib/assets/img/perfil.png",
                    isHistory: true,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
