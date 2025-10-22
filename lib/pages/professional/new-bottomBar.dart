import 'package:flutter/material.dart';

// Eu não sei o que cargas d'água aconteceu, mas eu fiz as modificações da bottom bar direto nesse código e na hora que fui tirar o resto para deixar apenas a bottom bar o código quebrava. Esse é o código com ela sendo utilizada, mas embiaxo vou deixar o código maluco separado mesmo assim.

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/logo(1).png',
                  width: 250,
                  height: 41,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF626BBA)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 11, top: 4),
                  child: Text(
                    "termos de uso e política de privacidade",
                    style: TextStyle(
                      color: Color(0xFF626BBA),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            color: Color(0xFF626BBA),
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
          selectedItemColor: const Color(0xFF626BBA),
          unselectedItemColor: const Color(0xFF626BBA),
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          currentIndex: 0,
          onTap: (index) {},
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





/*import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FF),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(
          color: const Color(0xFF626BBA),
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
        selectedItemColor: const Color(0xFF626BBA),
        unselectedItemColor: const Color(0xFF626BBA),
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: 0,
        onTap: (index) {},
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
    );
  }
}
*/