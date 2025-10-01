import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

const Color kPurpleMain = Colors.deepPurple;
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrayLight = Color(0xFFE9ECEF);
const Color kGrayText = Color(0xFF6C757D);
const Color kAvailableColor = kWhite;
const Color kUnavailableColor = kGrayLight;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Agendamento',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kPurpleMain,
        fontFamily: 'Poppins',
      ),
      home: const Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: SafeArea(child: SchedulePage()),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('pt', 'BR'),
    );
  }
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _timeSlots = [
    {'time': '8:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '9:30', 'isAvailable': false, 'isSelected': false, 'hover': false},
    {'time': '10:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '11:30', 'isAvailable': false, 'isSelected': false, 'hover': false},
    {'time': '12:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '13:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '14:30', 'isAvailable': false, 'isSelected': false, 'hover': false},
    {'time': '15:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '16:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '17:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '18:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
    {'time': '19:30', 'isAvailable': true, 'isSelected': false, 'hover': false},
  ];

  void _toggleTimeSlot(int index) {
    if (_timeSlots[index]['isAvailable']) {
      setState(() {
        _timeSlots[index]['isSelected'] = !_timeSlots[index]['isSelected'];
      });
    }
  }

  void _changeDay(bool next) {
    final hoje = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final proximo = next
        ? _selectedDate.add(const Duration(days: 1))
        : _selectedDate.subtract(const Duration(days: 1));
    
    final proximoDia = DateTime(proximo.year, proximo.month, proximo.day);

    if (!next && proximoDia.isBefore(hoje)) {
      return;
    }

    setState(() {
      _selectedDate = proximo;
      for (var slot in _timeSlots) {
        slot['isSelected'] = false;
        slot['hover'] = false;
      }
    });
  }
  
  Future<void> _openCalendar() async {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: today,
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        for (var slot in _timeSlots) {
          slot['isSelected'] = false;
          slot['hover'] = false;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    final format = DateFormat("EEEE, d 'de' MMMM 'de' y", 'pt_BR');
    String formattedDate = format.format(date);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  Widget _buildLegendCircle(Color color, String label, {Color borderColor = Colors.transparent}) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.0),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xFF343A40),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isToday = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
        .isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

    return Column(
      children: [
        AppBar(
          backgroundColor: kWhite,
          elevation: 1,
          automaticallyImplyLeading: false,
          leading: null,
          title: const Text(
            'Agendar Horário',
            style: TextStyle(
                color: kPurpleMain,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          color: kWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.chevronLeft, size: 18),
                onPressed: isToday ? null : () => _changeDay(false),
                color: isToday ? Colors.grey : const Color(0xFF343A40),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: _openCalendar,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          _formatDate(_selectedDate),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(FontAwesomeIcons.solidCalendarDays,
                          color: kPurpleMain, size: 16),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.chevronRight, size: 18),
                onPressed: () => _changeDay(true),
                color: const Color(0xFF343A40),
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendCircle(kWhite, "Disponível", borderColor: Colors.grey.shade400),
              const SizedBox(width: 12),
              _buildLegendCircle(kPurpleMain, "Selecionado"),
              const SizedBox(width: 12),
              _buildLegendCircle(kUnavailableColor, "Indisponível", borderColor: Colors.grey.shade400),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildTimeGrid(),
                          const SizedBox(height: 20),
                          _buildInfoAlert(),
                          const SizedBox(height: 20),
                          _buildSelectButton(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2.5,
      ),
      itemCount: _timeSlots.length,
      itemBuilder: (context, index) {
        final slot = _timeSlots[index];
        final isAvailable = slot['isAvailable'];
        final isSelected = slot['isSelected'];
        final isHover = slot['hover'] ?? false; 

        Color backgroundColor;
        Color textColor;
        Color borderColor;

        if (!isAvailable) {
          backgroundColor = kUnavailableColor;
          textColor = kGrayText;
          borderColor = kUnavailableColor;
        } else if (isSelected) {
          backgroundColor = kPurpleMain;
          textColor = kWhite;
          borderColor = kPurpleMain;
        } else if (isHover) {
          backgroundColor = kPurpleMain.withOpacity(0.2);
          textColor = kPurpleMain;
          borderColor = kPurpleMain.withOpacity(0.5);
        } else {
          backgroundColor = kAvailableColor;
          textColor = const Color(0xFF343A40);
          borderColor = Colors.grey.shade300;
        }

        return MouseRegion(
          onEnter: (_) {
            if (isAvailable && !isSelected) {
              setState(() {
                _timeSlots[index]['hover'] = true;
              });
            }
          },
          onExit: (_) {
            if (isAvailable && !isSelected) {
              setState(() {
                _timeSlots[index]['hover'] = false;
              });
            }
          },
          child: GestureDetector(
            onTap: isAvailable ? () => _toggleTimeSlot(index) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(8),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: kPurpleMain.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2))
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  slot['time'],
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoAlert() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: kPurpleMain.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.circleInfo, color: kPurpleMain, size: 16),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              'Para procedimentos longos, selecione 2 ou mais horários.',
              style: TextStyle(
                  fontSize: 13,
                  color: kPurpleMain,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final selectedTimes = _timeSlots
              .where((slot) => slot['isSelected'] == true)
              .map((slot) => slot['time'])
              .toList();

          if (selectedTimes.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Agendado para ${_formatDate(_selectedDate)} às ${selectedTimes.join(', ')}'),
                backgroundColor: kPurpleMain,
                duration: const Duration(seconds: 3),
              ),
            );
          } else {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Por favor, selecione um horário.'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPurpleMain,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Text(
          'Confirmar Agendamento',
          style: TextStyle(
            color: kWhite,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}