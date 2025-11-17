import 'package:flutter/material.dart';
import 'package:loc_casion/widgets/app_background.dart';
import 'package:loc_casion/services/token_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await TokenStorage.getUser();
    setState(() {
      email = user?["email"] ?? "Utilisateur";
    });
  }

  Future<void> _logout() async {
    await TokenStorage.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 AJOUT DU BOUTON RETOUR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0AE2D0)),
                    ),

                    const Text(
                      "Profil",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: _logout,
                      icon: const Icon(Icons.logout, color: Color(0xFF0AE2D0)),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // INFO PROFIL
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xFF0AE2D0),
                        child: Icon(Icons.person, size: 40, color: Colors.black),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            email ?? "Chargement...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Membre Loc'casion",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // SECTION : MES ANNONCES
                const Text(
                  "Mes annonces",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _groupCard(
                  icon: Icons.add_box,
                  label: "Voir mes annonces",
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _groupCard(
                  icon: Icons.add_circle_outline,
                  label: "Créer une nouvelle annonce",
                  onTap: () => Navigator.pushNamed(context, '/add-item'),
                ),

                const SizedBox(height: 40),

                // SECTION : MES LOCATIONS
                const Text(
                  "Mes locations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _groupCard(
                  icon: Icons.shopping_bag,
                  label: "Locations en cours",
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _groupCard(
                  icon: Icons.history,
                  label: "Historique des locations",
                  onTap: () {},
                ),

                const SizedBox(height: 40),

                // SECTION : PARAMETRES
                const Text(
                  "Paramètres",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _groupCard(
                  icon: Icons.lock_reset,
                  label: "Changer le mot de passe",
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _groupCard(
                  icon: Icons.delete_forever,
                  label: "Supprimer mon compte",
                  onTap: () {},
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _groupCard({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0AE2D0), size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }
}