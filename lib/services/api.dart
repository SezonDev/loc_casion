import 'dart:convert';
import 'dart:io';                          // 🔥 IMPORTANT pour File
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  /// 🔥 Choix automatique de l’URL selon la plateforme
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:3000"; // Flutter Web
    } else {
      return "http://10.0.2.2:3000"; // Android Emulator
      // Pour iOS Simulator → "http://localhost:3000"
    }
  }
}

class Api {
  /// 🔐 LOGIN
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"error": true, "message": "Impossible de contacter le serveur ($e)"};
    }
  }

  /// 🆕 REGISTER
  static Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"error": true, "message": "Impossible de contacter le serveur ($e)"};
    }
  }

  /// 📦 CREATE ITEM
  static Future<Map<String, dynamic>> createItem(
      String title, String description, String? imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiConfig.baseUrl}/items"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "description": description,
          "imageUrl": imageUrl,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        "error": true,
        "message": "Erreur réseau : impossible de créer l’objet ($e)"
      };
    }
  }

  /// 📤 UPLOAD IMAGE
  static Future<String?> uploadImage(File file) async {
    final uri = Uri.parse("${ApiConfig.baseUrl}/upload");
    final request = http.MultipartRequest("POST", uri);

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
    ));

    final response = await request.send();
    final resString = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      final json = jsonDecode(resString);
      return json["url"]; // URL renvoyée par ton API NestJS
    } else {
      throw Exception("Échec de l'upload de l'image");
    }
  }

  static Future<Map<String, dynamic>?> getLastItems() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConfig.baseUrl}/items/last"),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {"items": []};
    }
  }
}
