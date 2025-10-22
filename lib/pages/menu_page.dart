import 'package:flutter/material.dart';
// [NOVO] Importa o Gatilho (O botão de tema)
import '../widgets/theme_toggle_button.dart'; 

import 'edit_menu_page.dart';
import 'privacy_policy_page.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Menu Principal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // Adaptado para usar a cor primária do tema
                      color: Theme.of(context).colorScheme.primary, 
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const _UsernameField(),
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
              Text(
                'Meus Dados',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              const _PersonalDataField(
                icon: Icons.person,
                label: 'Nome',
                isMultiField: true,
                secondLabel: 'Sobrenome',
              ),
              const _PersonalDataField(
                icon: Icons.phone,
                label: 'Telefone',
              ),
              const _PersonalDataField(
                icon: Icons.home,
                label: 'Endereço',
              ),
              const _PersonalDataField(
                icon: Icons.email,
                label: 'E-mail',
              ),
              const SizedBox(height: 20),
              const _EditDataButton(),
              const SizedBox(height: 40),
              const _LogoutButton(),
            ],
          ),
        ),
      ),
      
      // 🔥 O GATILHO: Adiciona o botão flutuante que dispara a mudança de tema (completa o Observer).
      floatingActionButton: const ThemeToggleButton(),
    );
  }
}

// ------------------------------------------------------------------
// WIDGETS DE SUPORTE (Com adaptações de tema)
// ------------------------------------------------------------------

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        // Usa cardColor que se adapta a temas Light/Dark
        color: Theme.of(context).cardColor, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Text(
            '@username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              // Usa a cor de texto que se adapta a temas Light/Dark
              color: Theme.of(context).textTheme.bodyLarge?.color, 
            ),
          ),
          const Spacer(),
          Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 5),
          Text(
            '4.5',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Theme.of(context).textTheme.bodyLarge?.color),
              const SizedBox(height: 5),
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
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
  final bool isMultiField;
  final String? secondLabel;

  const _PersonalDataField({
    Key? key,
    required this.icon,
    required this.label,
    this.isMultiField = false,
    this.secondLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color fieldColor = Theme.of(context).cardColor;
    Color iconBackgroundColor = Theme.of(context).colorScheme.primary;
    // Garante que o texto seja legível em Light/Dark
    Color textColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black; 

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isMultiField
          ? Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: iconBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Icon(icon, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: fieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        secondLabel!,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: fieldColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(label, style: TextStyle(color: textColor)),
                  ),
                ],
              ),
            ),
    );
  }
}

class _EditDataButton extends StatelessWidget {
  const _EditDataButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditMenuPage()),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Editar Dados',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
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
    Color fieldColor = Theme.of(context).cardColor;
    Color errorColor = Theme.of(context).colorScheme.error;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: errorColor,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: errorColor),
        ],
      ),
    );
  }
}