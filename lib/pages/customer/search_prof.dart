import 'professional_page.dart';
import 'package:flutter/material.dart';

class SearchProfPage extends StatefulWidget {
  const SearchProfPage({super.key});

  @override
  State<SearchProfPage> createState() => _SearchProfPageState();
}

class _SearchProfPageState extends State<SearchProfPage> {
  double _selectedPrice = 100;

  void _openFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filtros",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Preço
                  const Text("Preço", style: TextStyle(fontWeight: FontWeight.w500)),
                  Slider(
                    value: _selectedPrice,
                    min: 0,
                    max: 500,
                    divisions: 10,
                    label: "R\$${_selectedPrice.round()}",
                    onChanged: (value) {
                      setModalState(() {
                        _selectedPrice = value;
                      });
                    },
                  ),
                  Text(
                    "Selecionado: R\$${_selectedPrice.round()}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  // Endereço
                  const Text("Endereço", style: TextStyle(fontWeight: FontWeight.w500)),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Digite o seu bairro",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Tipo de serviço estético
                  const Text("Tipo de Serviço Estético", style: TextStyle(fontWeight: FontWeight.w500)),
                  DropdownButtonFormField<String>(
                    items: const [
                      DropdownMenuItem(value: "Cabelo", child: Text("Cabelo")),
                      DropdownMenuItem(value: "Maquiagem", child: Text("Maquiagem")),
                      DropdownMenuItem(value: "Unhas", child: Text("Unhas")),
                      DropdownMenuItem(value: "Massagem", child: Text("Massagem")),
                      DropdownMenuItem(value: "SkinCare", child: Text("SkinCare")),
                      DropdownMenuItem(value: "Sobrancelha", child: Text("Sobrancelha")),
                    ],
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botão Verificar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 92, 98, 158),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Verificar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProfessionalCard({
    required String name,
    required String address,
    required String imageUrl,
    required double rating,
  }) {
    return GestureDetector(
      onTap: () {
        // 🚀 Agora redireciona pra página ProfessionalPageClient
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalPageClient(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(address, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 6),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating.floor() ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          );
                        }),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // logo no topo
            Row(
              children: [
                Image.asset(
                  'lib/assets/img/logo.png',
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // campo de pesquisa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Pesquisar...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _openFilterModal,
                  icon: const Icon(Icons.filter_list, color: Color.fromARGB(255, 92, 98, 158), size: 28),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // lista de profissionais
            Expanded(
              child: ListView(
                children: [
                  _buildProfessionalCard(
                    name: "Giovanna",
                    address: "Hickley Blvd, 774",
                    imageUrl: "lib/assets/img/person1.png",
                    rating: 4.5,
                  ),
                  _buildProfessionalCard(
                    name: "Mary",
                    address: "Hickley Blvd, 2343",
                    imageUrl: "lib/assets/img/person2.png",
                    rating: 4.2,
                  ),
                  _buildProfessionalCard(
                    name: "Clara",
                    address: "Sunset St, 12",
                    imageUrl: "lib/assets/img/person3.png",
                    rating: 4.8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}