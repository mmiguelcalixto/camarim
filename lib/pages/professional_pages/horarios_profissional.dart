import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Importamos APENAS a cor. Se a cor não estiver definida em 'new-bottomBar.dart',
// faremos a definição aqui. Vamos usar a cor do seu código de referência.
const Color primaryThemeColor = Color(0xFF626BBA); 
const Color backgroundNavColor = Color(0xFFF9F9FF);

// Este é um modelo de dados simples para o horário
class Horario {
  final String hora;
  bool estaDisponivel; 

  Horario(this.hora, {this.estaDisponivel = true});
}

class AgendaProfissionalPage extends StatefulWidget {
  const AgendaProfissionalPage({super.key});

  @override
  State<AgendaProfissionalPage> createState() => _AgendaProfissionalPageState();
}

class _AgendaProfissionalPageState extends State<AgendaProfissionalPage> {
  // --- VARIÁVEIS DE ESTADO ---
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  final Map<DateTime, List<Horario>> _horariosPorDia = {};
  
  // Estado da Barra de Navegação
  int _selectedIndex = 1; // Definindo 'Hours' (Agenda) como a aba inicial (Índice 1)
  late List<Widget> _widgetOptions; 

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadSampleData(_focusedDay);

    // Lista de páginas do BottomNav (Agenda está no índice 1)
    _widgetOptions = <Widget>[
      const Center(child: Text("Página Wallet", style: TextStyle(fontSize: 18, color: primaryThemeColor))), // Índice 0
      _buildAgendaBody(), // Índice 1: Agenda/Hours
      const Center(child: Text("Página Profile", style: TextStyle(fontSize: 18, color: primaryThemeColor))), // Índice 2
      const Center(child: Text("Página Menu", style: TextStyle(fontSize: 18, color: primaryThemeColor))), // Índice 3
    ];
  }
  
  // (*** Funções de lógica da agenda... ***)
  void _loadSampleData(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    if (_horariosPorDia.containsKey(normalizedDay)) return;
    List<Horario> horarios = [];
    for (int i = 9; i <= 17; i++) {
      horarios.add(Horario('${i.toString().padLeft(2, '0')}:00'));
    }
    _horariosPorDia[normalizedDay] = horarios;
  }

  void _toggleAvailability(Horario horario) {
    setState(() {
      horario.estaDisponivel = !horario.estaDisponivel;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _loadSampleData(selectedDay);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // --- WIDGET DO CORPO DA AGENDA (ÍNDICE 1) ---

  Widget _buildAgendaBody() {
    final normalizedSelectedDay = _selectedDay != null
        ? DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day)
        : null;

    final List<Horario> horariosDoDia =
        normalizedSelectedDay != null ? (_horariosPorDia[normalizedSelectedDay] ?? []) : [];

    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CALENDÁRIO
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
              ),
              // Estilização do Calendário com a cor do tema
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: primaryThemeColor,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: primaryThemeColor,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.red),
              ),
            ),
            const Divider(color: Colors.black12, height: 1.0),
            
            // 2. LISTA DE HORÁRIOS PARA O DIA SELECIONADO
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Definir Disponibilidade em ${_selectedDay != null ? '${_selectedDay!.day}/${_selectedDay!.month}' : 'o dia selecionado'}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            
            if (horariosDoDia.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Selecione um dia para gerenciar os horários.', style: TextStyle(fontStyle: FontStyle.italic)),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: horariosDoDia.map((horario) {
                    return ActionChip(
                      avatar: Icon(
                        horario.estaDisponivel ? Icons.lock_open : Icons.lock,
                        color: horario.estaDisponivel ? primaryThemeColor : Colors.white,
                      ),
                      label: Text(
                        horario.hora,
                        style: TextStyle(
                          color: horario.estaDisponivel ? primaryThemeColor : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: horario.estaDisponivel ? primaryThemeColor.withOpacity(0.1) : primaryThemeColor,
                      side: const BorderSide(color: primaryThemeColor, width: 1.5),
                      onPressed: () => _toggleAvailability(horario),
                      tooltip: horario.estaDisponivel ? 'Clique para BLOQUEAR' : 'Clique para DISPONIBILIZAR',
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      );
  }

  // --- WIDGET PRINCIPAL (SCAFFOLD) ---

  @override
  Widget build(BuildContext context) {
    String appBarTitle = _selectedIndex == 1 ? 'Minha Agenda' : _widgetOptions[_selectedIndex] is Center ? (_widgetOptions[_selectedIndex] as Center).child.toString().replaceAll('Text("Página ', '').replaceAll('"', '').replaceAll(')', '') : 'Meu App';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryThemeColor,
        elevation: 0,
        centerTitle: true,
      ),
      
      // O corpo muda com base na aba selecionada
      body: _widgetOptions.elementAt(_selectedIndex),
      
      // --- BARRA DE NAVEGAÇÃO COPIADA DO CÓDIGO DE REFERÊNCIA ---
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgroundNavColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: primaryThemeColor,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: primaryThemeColor,
          unselectedItemColor: primaryThemeColor,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: _selectedIndex, // Usa o estado atual
          onTap: _onItemTapped, // Usa a função de navegação
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Hours",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Menu",
            ),
          ],
        ),
      ),
    );
  }
}