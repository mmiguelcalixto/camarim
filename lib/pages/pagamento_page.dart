import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PagamentoPage extends StatefulWidget {
  const PagamentoPage({super.key});

  @override
  State<PagamentoPage> createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  String? _selectedOption;

  final List<Map<String, dynamic>> paymentOptions = [
    {"label": "Cartão de Crédito", "icon": FontAwesomeIcons.creditCard, "value": "credito"},
    {"label": "Cartão de Débito", "icon": FontAwesomeIcons.solidCreditCard, "value": "debito"},
    {"label": "Pix", "icon": FontAwesomeIcons.boltLightning, "value": "pix"},
    {"label": "Boleto Bancário", "icon": FontAwesomeIcons.barcode, "value": "boleto"},
    {"label": "Cupom de Desconto", "icon": FontAwesomeIcons.ticket, "value": "cupom"},
    {"label": "PayPal", "icon": FontAwesomeIcons.paypal, "value": "paypal"},
    {"label": "Apple Pay", "icon": FontAwesomeIcons.applePay, "value": "applepay"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 92, 98, 158)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Image.asset(
              "lib/assets/img/logo.png", 
              height: 40,       
            ),
            const SizedBox(height: 4),
            const Text(
              "Escolha a melhor forma de pagamento",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 92, 98, 158),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: paymentOptions.length,
                itemBuilder: (context, index) {
                  final option = paymentOptions[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color.fromARGB(255, 92, 98, 158).withOpacity(0.3)),
                    ),
                    child: RadioListTile<String>(
                      activeColor: Color.fromARGB(255, 92, 98, 158),
                      title: Row(
                        children: [
                          FaIcon(option["icon"], color: Color.fromARGB(255, 92, 98, 158)),
                          const SizedBox(width: 12),
                          Text(option["label"]),
                        ],
                      ),
                      value: option["value"],
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 92, 98, 158),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: _selectedOption == null
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Selecionado: $_selectedOption")),
                      );
                    },
              child: const Text(
                "Prosseguir",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        ),
      ),

      // NAVBAR igual à sua EditProfilePage
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FF),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: Color.fromARGB(255, 92, 98, 158),
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
          selectedItemColor: Color.fromARGB(255, 92, 98, 158),
          unselectedItemColor: Color.fromARGB(255, 92, 98, 158).withOpacity(0.5),
          currentIndex: 4, // "Menu" selecionado
          onTap: (index) {
            Navigator.pop(context);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Pesquisa"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Horários"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          ],
        ),
      ),
    );
  }
}