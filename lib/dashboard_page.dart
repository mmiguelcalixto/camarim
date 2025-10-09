import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryPurple = Theme.of(context).colorScheme.primary;
    final Color darkPurple = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: 40,
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.person_outline, color: darkPurple, size: 28),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, Profissional!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkPurple,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Bem-vindo(a) de volta.',
              style: TextStyle(
                fontSize: 16,
                color: primaryPurple,
              ),
            ),
            const SizedBox(height: 30),

            // Seção de Métricas Principais em um card único
            _buildMainMetrics(context, primaryPurple, darkPurple),
            const SizedBox(height: 30),

            // Seção de Nota do Profissional
            _buildSectionTitle('Nota do Profissional', context),
            const SizedBox(height: 10),
            _buildRatingSection(context, primaryPurple),
            const SizedBox(height: 30),

            // Seção de Origem das Clientes
            _buildSectionTitle('Origem das Clientes', context),
            const SizedBox(height: 10),
            _buildOriginSection(context, primaryPurple, darkPurple),
            const SizedBox(height: 30),

            // Seção de Serviços Mais Realizados
            _buildSectionTitle('Serviços Realizados', context),
            const SizedBox(height: 10),
            _buildServicesSection(context, primaryPurple, darkPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildMainMetrics(
      BuildContext context, Color primaryPurple, Color darkPurple) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Faturamento Total
            _buildMetricItem(
                context, 'Faturamento Total', 'R\$ 12.500,00', primaryPurple),
            const Divider(color: Colors.grey, height: 25),
            // Agendamentos e Atendidos lado a lado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetricItem(context, 'Agendamentos', '150', primaryPurple),
                _buildMetricItem(context, 'Atendidos', '120', primaryPurple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(
      BuildContext context, String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context, Color primaryPurple) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < 4 ? Icons.star : Icons.star_border,
                  color: index < 4 ? primaryPurple : Colors.grey[300],
                  size: 28,
                );
              }),
            ),
            Text(
              '4.0',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOriginSection(
      BuildContext context, Color primaryPurple, Color darkPurple) {
    final List<PieChartSectionData> pieChartData = [
      PieChartSectionData(
        color: primaryPurple.withOpacity(0.8),
        value: 45,
        title: '45%',
        radius: 60,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: darkPurple.withOpacity(0.8),
        value: 25,
        title: '25%',
        radius: 60,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: primaryPurple.withOpacity(0.4),
        value: 30,
        title: '30%',
        radius: 60,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: pieChartData,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(primaryPurple.withOpacity(0.8), 'Instagram'),
                _buildLegendItem(darkPurple.withOpacity(0.8), 'Google'),
                _buildLegendItem(
                    primaryPurple.withOpacity(0.4), 'Indicação'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildServicesSection(
      BuildContext context, Color primaryPurple, Color darkPurple) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildServiceItem('Corte', '50', primaryPurple, darkPurple),
            _buildServiceItem('Pintura', '30', primaryPurple, darkPurple),
            _buildServiceItem('Hidratação', '25', primaryPurple, darkPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(
      String service, String count, Color primaryPurple, Color darkPurple) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service,
            style: TextStyle(
              fontSize: 16,
              color: darkPurple,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              color: primaryPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}