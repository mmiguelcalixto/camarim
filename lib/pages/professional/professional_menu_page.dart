import 'dart:convert';

import 'package:camarim_backend/models/professional.dart';
import 'package:camarim_backend/pages/customer/login_page.dart';
import 'package:camarim_backend/pages/privacy_policy_page.dart';
import 'package:camarim_backend/services/login.service.dart';
import 'package:camarim_backend/services/professional.service.dart';
import 'package:camarim_backend/widgets/professional_bottom_navbar.dart';
import 'package:flutter/material.dart';

class ProfessionalMenuPage extends StatefulWidget {
  final String professionalId;
  const ProfessionalMenuPage(this.professionalId, {super.key});

  @override
  State<ProfessionalMenuPage> createState() => _ProfessionalMenuPageState();
}

class _ProfessionalMenuPageState extends State<ProfessionalMenuPage> {
  Professional? professional;

  @override
  void initState() {
    super.initState();
    _loadProfessional();
  }

  final professionalService = ProfessionalService();
  final loginService = LoginService();

  Future<void> _loadProfessional() async {
    final result = await professionalService.getProfessionalById(widget.professionalId);
    if (result != null) {
      final data = jsonDecode(result.body);

      setState(() {
        professional = Professional.fromJson(data);
      });
    }
  }

  Future<void> _logout() async {
    final response = await loginService.logout();

    if(response != null && response.statusCode == 200) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget usernameField() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.person, color: Colors.black),
            const SizedBox(width: 10),
            Text(
              professional?.name ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(Icons.star, color: Color.fromARGB(255, 92, 98, 158)),
            const SizedBox(width: 5),
            const Text(
              '4.5',
              style: TextStyle(
                color: Color.fromARGB(255, 92, 98, 158),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget customButton(IconData icon, String label, VoidCallback onTap) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30),
                const SizedBox(height: 5),
                Text(label),
              ],
            ),
          ),
        ),
      );
    }

    Widget logoutButton() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _logout,
              child: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/img/logo.png',
                    height: 40,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Menu Principal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 92, 98, 158),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              usernameField(),
              const SizedBox(height: 20),
              Row(
                children: [
                  customButton(
                    Icons.lock,
                    'Privacidade',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              logoutButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProfessionalBottomNavBar(
        professionalId: widget.professionalId,
        currentIndex: 2,
      ),
    );
  }
}