import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Profissional',
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Hours"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // HEADER
            Container(
              height: 150,
              color: Colors.grey[300],
              child: const Center(child: Text("Add a header +")),
            ),
            const SizedBox(height: 16),

            // FOTO DE PERFIL
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.add, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),

            // NOME E BIO
            const Center(
              child: Text(
                "Laura Nails & Hair",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Sou formada pelo Instituto L'Oréal BH e atuo na área há mais de 10 anos.\nVeja meu trabalho e se surpreenda :)",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: const Text("Edit biography"),
            ),
            const SizedBox(height: 20),

            // LATEST WORKS
            const Text("latest works", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // SERVICES
            const Text("services", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const Wrap(
              spacing: 8,
              children: [
                Chip(label: Text("Unhas de gel")),
                Chip(label: Text("Manicure/Pedicure")),
                Chip(label: Text("Corte")),
                Chip(label: Text("Tintura")),
                Chip(label: Text("Descoloração")),
                Chip(label: Text("Tons Fantasia")),
                Chip(label: Text("Loiros")),
                Chip(label: Text("Maquiagem")),
                Chip(label: Text("Add service +")),
              ],
            ),
            const SizedBox(height: 20),

            // CAREER
            const Text("career", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Text("Add an institution\nWhat do you learn?")),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Text("Institution details timeline...")),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // DIFERENCIAIS
            const Text("✦ Este profissional atende a domicílio"),
            const Text("✦ Add another differential +"),
            const SizedBox(height: 20),

            // LOCATION
            const Text("location", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text("Mapa (Google Maps aqui)")),
            ),
            const SizedBox(height: 20),

            // SOCIAL MEDIA
            const Text("social medias", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("📸 your instagram link"),
                Text("💼 your linkedin link"),
                Text("🎵 your tiktok link"),
                Text("🐦 your X link"),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
