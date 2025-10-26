import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camarim_backend/services/customer.service.dart';
import 'package:camarim_backend/models/customer_profile.dart';
import 'edit_menu_page.dart';
import 'package:camarim_backend/pages/privacy_policy_page.dart';

class MenuPage extends StatefulWidget {
  final String customerId;
  const MenuPage(this.customerId, {super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<CustomerProfile> _customerProfileFuture;
  final CustomerService _customerService = CustomerService();

  @override
  void initState() {
    super.initState();
    _customerProfileFuture = _loadCustomerProfile();
  }

  Future<CustomerProfile> _loadCustomerProfile() async {
    final service = CustomerService();
    final result = await service.getCustomerProfile(widget.customerId);

    if (result == null) {
      throw Exception('ID do cliente não encontrado. Faça o login novamente.');
    }

    return await _customerService.getCustomerProfile(widget.customerId);
  }


  void _refreshData() {
    setState(() {
      _customerProfileFuture = _loadCustomerProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<CustomerProfile>(
        future: _customerProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          }

          final customer = snapshot.data!;

          return SafeArea(
            child: SingleChildScrollView(
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

                    _UsernameField(username: customer.username),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        _CustomButton(
                          icon: Icons.lock,
                          label: 'Privacidade',
                          onTap: () {
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

                    const SizedBox(height: 20),
                    const Text(
                      'Meus Dados',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 92, 98, 158),
                      ),
                    ),
                    const SizedBox(height: 10),

                    _PersonalDataField(
                      icon: Icons.person,
                      label: customer.fullName,
                    ),
                    _PersonalDataField(
                      icon: Icons.phone,
                      label: customer.phone,
                    ),
                    _PersonalDataField(
                      icon: Icons.home,
                      label:
                          '${customer.addressStreet}, ${customer.addressNumber}',
                    ),
                    _PersonalDataField(
                      icon: Icons.email,
                      label: customer.email,
                    ),
                    const SizedBox(height: 20),

                    _EditDataButton(
                      customerProfile: customer,
                      onDataUpdated: _refreshData,
                    ),

                    const SizedBox(height: 40),

                    const _LogoutButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class _UsernameField extends StatelessWidget {
  final String username;
  const _UsernameField({required this.username});

  @override
  Widget build(BuildContext context) {
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
            '@$username',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _CustomButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _PersonalDataField extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PersonalDataField({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 92, 98, 158),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditDataButton extends StatelessWidget {
  final CustomerProfile customerProfile;
  final VoidCallback onDataUpdated;

  const _EditDataButton({
    Key? key,
    required this.customerProfile,
    required this.onDataUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromARGB(255, 92, 98, 158);
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EditMenuPage(customerProfile: customerProfile),
          ),
        );
        if (result == true) {
          onDataUpdated();
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Editar Dados',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
          ],
        ),
      ),
    );
  }
}