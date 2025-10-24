import 'package:flutter/material.dart';
import '../models/search_filter.dart';
import '../models/search_result.dart';
import '../services/professional.service.dart';
import 'professional_page.dart';

class SearchProfPage extends StatefulWidget {
  const SearchProfPage({super.key});

  @override
  State<SearchProfPage> createState() => _SearchProfPageState();
}

class _SearchProfPageState extends State<SearchProfPage> {
  final ProfessionalService _service = ProfessionalService();
  List<SearchResult> _results = [];
  bool _isLoading = false;

  final _neighborhoodController = TextEditingController();
  String? _selectedServiceType;
  double _selectedPrice = 500;

  void _performSearch({String? query, SearchFilter? filter}) async {
    setState(() => _isLoading = true);
    try {
      final professionals = await _service.searchProfessionals(
        query: query,
        filter: filter,
      );
      setState(() => _results = professionals);
    } catch (e) {
      print("Erro na busca: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

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
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Filtros",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Preço Máximo: R\$${_selectedPrice.round()}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Slider(
                      value: _selectedPrice,
                      min: 0,
                      max: 500,
                      divisions: 10,
                      label: "R\$${_selectedPrice.round()}",
                      onChanged:
                          (value) =>
                              setModalState(() => _selectedPrice = value),
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      "Endereço (Bairro)",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: _neighborhoodController,
                      decoration: InputDecoration(
                        hintText: "Digite o seu bairro",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    const Text(
                      "Tipo de Serviço",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    DropdownButtonFormField<String>(
                      value: _selectedServiceType,
                      items: const [
                        DropdownMenuItem(value: "HAIR", child: Text("Cabelo")),
                        DropdownMenuItem(
                          value: "MAKEUP",
                          child: Text("Maquiagem"),
                        ),
                        DropdownMenuItem(
                          value: "MANICURE",
                          child: Text("Manicure"),
                        ),
                        DropdownMenuItem(
                          value: "PEDICURE",
                          child: Text("Pedicure"),
                        ),
                        DropdownMenuItem(
                          value: "AESTHETICS",
                          child: Text("Estética"),
                        ),
                      ],
                      onChanged:
                          (value) =>
                              setModalState(() => _selectedServiceType = value),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Botao de filtro foi clicado');
                          final filter = SearchFilter(
                            neighborhood: _neighborhoodController.text,
                            serviceType: _selectedServiceType,
                            priceMax:
                                _selectedPrice == 0
                                    ? null
                                    : _selectedPrice, 
                          );
                          Navigator.pop(context);
                          _performSearch(filter: filter);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            92,
                            98,
                            158,
                          ),
                        ),
                        child: const Text(
                          "Aplicar Filtros",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProfessionalCard(SearchResult result) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      ProfessionalPageClient(professionalId: result.id),
            ),
          ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  result.profileImageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result.addressCity,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    if (result.rating > 0)
                      Row(
                        children: [
                          Text(
                            result.rating.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('lib/assets/img/logo.png', height: 40),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => _performSearch(query: value),
                      decoration: InputDecoration(
                        hintText: "Pesquisar por nome...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade200,
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
                    icon: const Icon(
                      Icons.filter_list,
                      color: Color.fromARGB(255, 92, 98, 158),
                      size: 28,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child:
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _results.isEmpty
                        ? const Center(
                          child: Text("Nenhum profissional encontrado."),
                        )
                        : ListView.builder(
                          itemCount: _results.length,
                          itemBuilder:
                              (context, index) =>
                                  _buildProfessionalCard(_results[index]),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
