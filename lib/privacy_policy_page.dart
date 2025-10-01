import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool concordo = false;
  int paginaAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF626BBA)),
          onPressed: () {},
        ),
        title: const Text(
          "termos de uso e política de privacidade",
          style: TextStyle(
            color: Color(0xFF626BBA),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF626BBA)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    """Art. I. Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
Donec scelerisque libero ex, tincidunt venenatis lectus ornare sit amet.
Art. II. Nullam leo nisl, maximus in nisl gravida, scelerisque mattis nibh. 
Morbi nec nibh vestibulum, vestibulum massa vitae, vulputate tortor. 
Integer mi mi, efficitur vitae faucibus eget, ullamcorper sit amet ex.
Art. III. Maecenas eu lectus eu ligula sodales feugiat id at ante. 
Etiam leo tellus, posuere ut semper a, semper porttitor diam.
Art. IV. Nam elementum semper hendrerit. In hac habitasse platea dictumst. 
Proin urna arcu, placerat id ipsum et, venenatis ultrices justo.
Art. V. Maecenas mollis nec quam eu vulputate. Sed non libero sodales, 
blandit enim congue, scelerisque lacus.
Art. VI. Aenean at elit in tortor varius malesuada eget mi.
Art. VII. Pellentesque et nulla nec leo blandit, fringilla nisi vel, vehicula metus. 
Sed et sem finibus, auctor sapien nec, tincidunt dolor.""",
                    style: TextStyle(fontSize: 16, height: 1.2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: concordo,
                  onChanged: (value) {
                    setState(() {
                      concordo = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "Li e estou de acordo com os Termos de Uso e Política de Privacidade",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: concordo ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "prosseguir",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
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
