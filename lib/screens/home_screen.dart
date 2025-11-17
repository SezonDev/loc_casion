// ✨ HomeScreen avec 3 boutons en bas style Profil (sans bottomNavigationBar)

import 'package:flutter/material.dart';
import 'package:loc_casion/widgets/app_background.dart';
import 'package:loc_casion/services/api.dart';
import 'package:loc_casion/services/token_storage.dart';
import 'package:loc_casion/screens/profile_screen.dart';
import 'package:loc_casion/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> items = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final response = await Api.getLastItems();
    setState(() {
      items = response?["items"] ?? [];
      loading = false;
    });
  }

  Future<void> openProfile() async {
    final user = await TokenStorage.getUser();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            user == null ? const LoginScreen() : const ProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🧩 CONTENU PRINCIPAL
          AppBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Loc'casion",
                          style: TextStyle(
                            color: Color(0xFF0AE2D0),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Dernières annonces",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // LISTE DES ITEMS
                    Expanded(
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF0AE2D0),
                              ),
                            )
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.only(bottom: 90), // pour laisser la place aux boutons
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];

                                return Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white.withOpacity(0.05),
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    border: Border.all(
                                        color: Colors.white24),
                                  ),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      child: Image.network(
                                        item["imageUrl"] ??
                                            "https://via.placeholder.com/80",
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      item["title"] ?? "Sans titre",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      item["description"] ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔻 BARRE DE 3 BOUTONS STYLE PROFIL
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: Row(
              children: [
                Expanded(
                  child: _navGlassButton(
                    icon: Icons.home,
                    label: "Home",
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _navGlassButton(
                    icon: Icons.add_circle_outline,
                    label: "Ajouter",
                    onTap: () => Navigator.pushNamed(context, "/add-item"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _navGlassButton(
                    icon: Icons.person,
                    label: "Profil",
                    onTap: () async {
                      final user = await TokenStorage.getUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => user == null
                              ? const LoginScreen()
                              : const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎨 BOUTON STYLE PROFIL (même style que _groupCard)
  Widget _navGlassButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF0AE2D0), size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
