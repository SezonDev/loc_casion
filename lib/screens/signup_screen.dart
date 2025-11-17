import 'package:flutter/material.dart';
import 'package:loc_casion/widgets/app_background.dart';
import 'package:loc_casion/services/api.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  Future<void> signUp() async {
    setState(() => loading = true);

    try {
      final response = await Api.register(
        email.text.trim(),
        password.text.trim(),
      );

      if (response["token"] != null) {
        // TODO : sauvegarder token dans SharedPreferences
        Navigator.pop(context); // Retour au login
      } else {
        throw Exception(response["message"] ?? "Erreur inconnue");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RETOUR
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0AE2D0)),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Créer un compte",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Bienvenue chez Loc'casion ✨",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 40),

                // EMAIL
                _buildField("Email", email, false),

                const SizedBox(height: 20),

                // MOT DE PASSE
                _buildField("Mot de passe", password, true),

                const SizedBox(height: 30),

                // CONFIRMATION BOUTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading ? null : signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0AE2D0),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text("S'inscrire", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
      String label, TextEditingController controller, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF0AE2D0)),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF0AE2D0), width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
