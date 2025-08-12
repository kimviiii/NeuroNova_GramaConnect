import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'https://api.gramaconnect.gov.lk';
  static const Duration timeoutDuration = Duration(seconds: 30);

  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Authentication endpoints
  static Future<User?> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/login'),
            headers: headers,
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      // For demo purposes, return a mock user
      if (email == 'demo@gramaconnect.lk' && password == 'demo123') {
        return User(
          id: 'demo-user-1',
          name: 'Demo User',
          email: email,
          phone: '+94771234567',
          role: 'citizen',
          createdAt: DateTime.now(),
        );
      }
      throw Exception('Network error: $e');
    }
  }

  static Future<User?> register(
      String name, String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/register'),
            headers: headers,
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
            }),
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      // For demo purposes, create a mock user
      return User(
        id: 'user-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        role: 'citizen',
        createdAt: DateTime.now(),
      );
    }
  }

  // Services endpoints
  static Future<List<Map<String, dynamic>>> getServices() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/services'),
            headers: headers,
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['services']);
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      // Return mock services for demo
      return [
        {
          'id': '1',
          'name': 'Birth Certificate',
          'name_si': 'උපන් සහතිකය',
          'name_ta': 'பிறப்பு சான்றிதழ்',
          'description': 'Apply for birth certificate',
          'icon': 'certificate',
          'category': 'certificates',
          'fee': 500.0,
        },
        {
          'id': '2',
          'name': 'Character Certificate',
          'name_si': 'චරිත සහතිකය',
          'name_ta': 'நல்லொழுக்க சான்றிதழ்',
          'description': 'Apply for character certificate',
          'icon': 'certificate',
          'category': 'certificates',
          'fee': 300.0,
        },
        // Add more mock services
      ];
    }
  }

  // Complaints endpoints
  static Future<bool> submitComplaint(Map<String, dynamic> complaint) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/complaints'),
            headers: headers,
            body: jsonEncode(complaint),
          )
          .timeout(timeoutDuration);

      return response.statusCode == 201;
    } catch (e) {
      // For demo purposes, always return true
      return true;
    }
  }

  static Future<List<Map<String, dynamic>>> getComplaints(String userId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/complaints/user/$userId'),
            headers: headers,
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['complaints']);
      } else {
        throw Exception('Failed to load complaints');
      }
    } catch (e) {
      // Return mock complaints for demo
      return [
        {
          'id': 'complaint-1',
          'title': 'Road Damage',
          'description': 'There is a pothole on Main Street',
          'status': 'pending',
          'createdAt': DateTime.now()
              .subtract(const Duration(days: 2))
              .toIso8601String(),
        },
      ];
    }
  }

  // Announcements endpoints
  static Future<List<Map<String, dynamic>>> getAnnouncements() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/announcements'),
            headers: headers,
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['announcements']);
      } else {
        throw Exception('Failed to load announcements');
      }
    } catch (e) {
      // Return mock announcements for demo
      return [
        {
          'id': '1',
          'title': 'New Service Available',
          'title_si': 'නව සේවාව ලබා ගැනීමට',
          'title_ta': 'புதிய சேவை கிடைக்கிறது',
          'content': 'Online birth certificate service is now available',
          'publishedAt': DateTime.now()
              .subtract(const Duration(days: 1))
              .toIso8601String(),
        },
      ];
    }
  }
}
