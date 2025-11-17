import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  // 🔐 Sauvegarde du token JWT
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  // 📥 Récupération du token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  // 🗑️ Suppression du token + user
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("user");
  }

  // 👤 Sauvegarde des infos utilisateur
  static Future<void> saveUser(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(data));
  }

  // 👤 Récupération des infos utilisateur
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("user");

    if (data == null) return null;
    return jsonDecode(data);
  }

  // 🔍 Vérifie si connecté
  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != null;
  }
}
