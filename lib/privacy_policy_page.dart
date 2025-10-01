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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Início',
              isSelected: paginaAtual == 0,
              onTap: () => setState(() => paginaAtual = 0),
            ),
            _NavItem(
              icon: Icons.search,
              label: 'Buscar',
              isSelected: paginaAtual == 1,
              onTap: () => setState(() => paginaAtual = 1),
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Perfil',
              isSelected: paginaAtual == 2,
              onTap: () => setState(() => paginaAtual = 2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Color(0xFF626BBA) : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Color(0xFF626BBA) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
