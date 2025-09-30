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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Termos de Uso e Política de Privacidade",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
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
                  border: Border.all(color: Colors.grey.shade400),
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
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                    style: TextStyle(fontSize: 14),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        onTap: (index) {
          setState(() {
            paginaAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
//teste