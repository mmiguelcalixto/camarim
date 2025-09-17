import 'package:flutter/material.dart';

class ContratarPage extends StatefulWidget {
  const ContratarPage({super.key});

  @override
  State<ContratarPage> createState() => _ContratarPageState();
}

class _ContratarPageState extends State<ContratarPage> {
  String? _selectedService;
  DateTime? _selectedDateTime;

  final List<String> _services = [
    "Esmaltação em gel",
    "Corte de cabelo",
    "Maquiagem",
    "Hidratação"
  ];

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // foto + título
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/img/gabriel.jpg"),
              ),
              const SizedBox(height: 12),
              const Text(
                "Contratar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 30),

              // selecionar serviço
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Selecione o serviço",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: _selectedService,
                items: _services.map((service) {
                  return DropdownMenuItem(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedService = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // selecionar data/hora
              ElevatedButton.icon(
                onPressed: _pickDateTime,
                icon: const Icon(Icons.calendar_today),
                label: const Text("Selecionar Horário"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              if (_selectedDateTime != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Selecionou: ${_selectedDateTime!.hour}:${_selectedDateTime!.minute.toString().padLeft(2, '0')} "
                    "- ${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),

              const Spacer(),

              // botão prosseguir
              ElevatedButton(
                onPressed: () {
                  if (_selectedService == null || _selectedDateTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Preencha todos os campos!")),
                    );
                  } else {
                    // redireciona ou faz ação
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade200,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Prosseguir"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
