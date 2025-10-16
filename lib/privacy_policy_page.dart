import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool concordo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF626BBA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/img/logo.png', 
          width: 180,
          height: 50,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            const Text(
              "Termos de Uso e Política de Privacidade",
              style: TextStyle(
                color: Color(0xFF626BBA),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF626BBA)),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    """Art. I. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Donec scelerisque libero ex, tincidunt venenatis lectus ornare sit amet.

Art. II. Nullam leo nisl, maximus in nisl gravida, scelerisque mattis nibh.
Morbi nec nibh vestibulum, vestibulum massa vitae, vulputate tortor.

Art. III. Maecenas eu lectus eu ligula sodales feugiat id at ante.
Etiam leo tellus, posuere ut semper a, semper porttitor diam.

Art. IV. Nam elementum semper hendrerit. In hac habitasse platea dictumst.
Proin urna arcu, placerat id ipsum et, venenatis ultrices justo.

Art. V. Maecenas mollis nec quam eu vulputate. Sed non libero sodales,
blandit enim congue, scelerisque lacus.

Art. VI. Aenean at elit in tortor varius malesuada eget mi.

Art. VII. Pellentesque et nulla nec leo blandit, fringilla nisi vel, vehicula metus.
Sed et sem finibus, auctor sapien nec, tincidunt dolor.""",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: concordo,
                  activeColor: const Color(0xFF626BBA),
                  onChanged: (value) {
                    setState(() => concordo = value ?? false);
                  },
                ),
                const Expanded(
                  child: Text(
                    "Li e estou de acordo com os Termos de Uso e Política de Privacidade",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: concordo ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF626BBA),
                  disabledBackgroundColor: const Color(0xFF626BBA).withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Prosseguir",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF626BBA),
        unselectedItemColor: const Color(0xFF626BBA).withOpacity(0.5),
        currentIndex: 4,
        onTap: (index) => Navigator.pop(context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Pesquisa"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Horários"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
    );
  }
}
