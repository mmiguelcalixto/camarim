import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/appointment.service.dart';
import '../models/professional_time_slot.dart';
import '../models/schedule_time.dart';
import 'pagamento_page.dart';

const Color kPurpleMain = Colors.deepPurple;
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrayLight = Color(0xFFE9ECEF);
const Color kGrayText = Color(0xFF6C757D);
const Color kAvailableColor = kWhite;
const Color kUnavailableColor = kGrayLight;

class ContratarPage extends StatefulWidget {
  final String professionalId;
  final String serviceId;

  const ContratarPage({
    super.key,
    required this.professionalId,
    required this.serviceId,
  });

  @override
  State<ContratarPage> createState() => _ContratarPageState();
}

class _ContratarPageState extends State<ContratarPage> {
  final AppointmentService _appointmentService = AppointmentService();

  DateTime _selectedDate = DateTime.now();
  late Future<List<ProfessionalTimeSlot>> _slotsFuture;
  ProfessionalTimeSlot? _selectedSlot;
  bool _isLoading = false;

  List<String> _generateAllTimeSlots() {
    return [
      '8:30',
      '9:30',
      '10:30',
      '11:30',
      '12:30',
      '13:30',
      '14:30',
      '15:30',
      '16:30',
      '17:30',
      '18:30',
      '19:30'
    ];
  }

  @override
  void initState() {
    super.initState();
    _fetchProfessionalTimes();
  }

  void _fetchProfessionalTimes() {
    setState(() {
      _slotsFuture =
          _appointmentService.getProfessionalTimes(widget.professionalId, _selectedDate);
      _selectedSlot = null;
    });
  }

  void _changeDay(bool next) {
    final hoje = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final proximo = next ? _selectedDate.add(const Duration(days: 1)) : _selectedDate.subtract(const Duration(days: 1));
    final proximoDia = DateTime(proximo.year, proximo.month, proximo.day);
    if (!next && proximoDia.isBefore(hoje)) return;
    setState(() {
      _selectedDate = proximo;
    });
    _fetchProfessionalTimes();
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
      });
      _fetchProfessionalTimes();
    }
  }

  String _formatDate(DateTime date) {
    final format = DateFormat("EEEE, d 'de' MMMM 'de' y", 'pt_BR');
    String formattedDate = format.format(date);
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  void _toggleSelectionByTimeString(String timeString, List<ProfessionalTimeSlot> slots) {
    try {
      final match = slots.firstWhere(
        (s) => DateFormat('H:mm').format(s.startsAt.toLocal()) == timeString,
      );

      setState(() {
        if (_selectedSlot == match) {
          _selectedSlot = null;
        } else {
          _selectedSlot = match;
        }
      });
    } on StateError {
      return;
    }
  }

  Future<void> _performSchedule() async {
    if (_selectedSlot == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecione um horário.'), backgroundColor: Colors.red),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final customerId = prefs.getString('customerId');
    if (customerId == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro: Faça o login novamente.'), backgroundColor: Colors.red));
      }
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    final request = ScheduleTimeRequest(
      professionalTimeId: _selectedSlot!.id,
      customerId: customerId,
      serviceId: widget.serviceId,
    );

    try {
      final success = await _appointmentService.scheduleTime(request);
      if (success && mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PagamentoPage()));
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não foi possível agendar.'), backgroundColor: Colors.red));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
              style: TextStyle(fontSize: 13, color: kPurpleMain, fontWeight: FontWeight.w500),
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
        onPressed: (_selectedSlot != null && !_isLoading) ? _performSchedule : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPurpleMain,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: kWhite, strokeWidth: 2)) : const Text(
          'Confirmar Agendamento',
          style: TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isToday = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
        .isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

    final allSlots = _generateAllTimeSlots();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              backgroundColor: kWhite,
              elevation: 1,
              automaticallyImplyLeading: true,
              title: const Text(
                'Agendar Horário',
                style: TextStyle(
                  color: kPurpleMain,
                  fontWeight: FontWeight.w600,
                ),
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
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(FontAwesomeIcons.solidCalendarDays, color: kPurpleMain, size: 16),
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
              child: FutureBuilder<List<ProfessionalTimeSlot>>(
                future: _slotsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar horários: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nenhum horário disponível para esta data.'));
                  }

                  final slots = snapshot.data!;

                  final Map<String, ProfessionalTimeSlot> timeToSlot = {
                    for (var s in slots) DateFormat('H:mm').format(s.startsAt.toLocal()): s
                  };

                  return SingleChildScrollView(
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
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 2.5,
                                    ),
                                    itemCount: allSlots.length,
                                    itemBuilder: (context, index) {
                                      final time = allSlots[index];
                                      final slot = timeToSlot[time];
                                      final isAvailable = slot != null && slot.isAvailable;
                                      final isSelected = slot != null && _selectedSlot == slot;

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
                                      } else {
                                        backgroundColor = kAvailableColor;
                                        textColor = const Color(0xFF343A40);
                                        borderColor = Colors.grey.shade300;
                                      }

                                      return GestureDetector(
                                        onTap: isAvailable ? () => _toggleSelectionByTimeString(time, slots) : null,
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          decoration: BoxDecoration(
                                            color: backgroundColor,
                                            border: Border.all(color: borderColor, width: 1.5),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              time,
                                              style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

