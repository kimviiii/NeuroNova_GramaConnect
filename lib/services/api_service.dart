import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class ApiService {
  // Dynamic base URL based on platform
  static String get baseUrl {
    if (kIsWeb) {
      // For web development
      return 'http://127.0.0.1:5000';
    } else if (Platform.isAndroid) {
      // For Android emulator (maps to host's 127.0.0.1)
      return 'http://192.168.34.215:5000';
    } else {
      // For iOS simulator and other platforms
      return 'http://127.0.0.1:5000';
    }
  }

  static const Duration timeoutDuration = Duration(seconds: 30);

  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Authentication endpoints
  static Future<User?> login(String email, String password) async {
    try {
      print('🔍 Attempting login to: $baseUrl/api/auth/login');

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/auth/login'),
            headers: headers,
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(timeoutDuration);

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Create user with token from backend response
        final userData = data['user'];
        userData['token'] = data['token']; // Add token to user data
        return User.fromJson(userData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? 'Login failed');
      }
    } catch (e) {
      print('❌ Login error: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception(
            'Network error: Cannot connect to server. Make sure the backend is running on $baseUrl');
      }
      throw Exception('Network error: $e');
    }
  }

  static Future<User?> register(String name, String email, String password,
      {String? phone, String? address, String? nic}) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'password': password,
      };

      if (phone != null && phone.isNotEmpty) body['phone'] = phone;
      if (address != null && address.isNotEmpty) body['address'] = address;
      if (nic != null && nic.isNotEmpty) body['nic'] = nic;

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/auth/register'),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(timeoutDuration);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['user']);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Multi-step registration endpoint
  static Future<User?> registerWithFullData(Map<String, dynamic> userData) async {
    try {
      print('🔍 Attempting multi-step registration to: $baseUrl/api/auth/register');
      print('📤 Registration data: $userData');

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/auth/register'),
            headers: headers,
            body: jsonEncode(userData),
          )
          .timeout(timeoutDuration);

      print('📡 Registration response status: ${response.statusCode}');
      print('📡 Registration response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // Create user with token from backend response
        final userResponse = data['user'];
        userResponse['token'] = data['token']; // Add token to user data
        return User.fromJson(userResponse);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? 'Registration failed');
      }
    } catch (e) {
      print('❌ Registration error: $e');
      if (e.toString().contains('SocketException')) {
        throw Exception(
            'Network error: Cannot connect to server. Make sure the backend is running on $baseUrl');
      }
      throw Exception('Network error: $e');
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

  // Government Services endpoints
  static Future<Map<String, dynamic>> submitMarriageCertificate({
    required String token,
    required Map<String, dynamic> applicationData,
  }) async {
    try {
      print('🔍 Submitting marriage certificate to: $baseUrl/api/services/marriage-certificate');

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/services/marriage-certificate'),
            headers: {
              ...headers,
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(applicationData),
          )
          .timeout(timeoutDuration);

      print('📡 Marriage Certificate Response: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to submit marriage certificate application');
      }
    } catch (e) {
      print('❌ Marriage Certificate Error: $e');
      throw Exception('Failed to submit application: $e');
    }
  }

  static Future<Map<String, dynamic>> submitCharacterCertificate({
    required String token,
    required Map<String, dynamic> applicationData,
  }) async {
    try {
      print('🔍 Submitting character certificate to: $baseUrl/api/services/character-certificate');

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/services/character-certificate'),
            headers: {
              ...headers,
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(applicationData),
          )
          .timeout(timeoutDuration);

      print('📡 Character Certificate Response: ${response.statusCode}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to submit character certificate application');
      }
    } catch (e) {
      print('❌ Character Certificate Error: $e');
      throw Exception('Failed to submit application: $e');
    }
  }

  static Future<Map<String, dynamic>> submitVoterRegistration({
    required String token,
    required Map<String, dynamic> applicationData,
  }) async {
    try {
      print('🔍 Submitting voter registration to: $baseUrl/api/services/voter-registration');

      final response = await http
          .post(
            Uri.parse('$baseUrl/api/services/voter-registration'),
            headers: {
              ...headers,
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(applicationData),
          )
          .timeout(timeoutDuration);

      print('📡 Voter Registration Response: ${response.statusCode}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to submit voter registration update');
      }
    } catch (e) {
      print('❌ Voter Registration Error: $e');
      throw Exception('Failed to submit application: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getUserApplications({
    required String token,
  }) async {
    try {
      print('🔍 Getting user applications from: $baseUrl/api/services/applications');

      final response = await http
          .get(
            Uri.parse('$baseUrl/api/services/applications'),
            headers: {
              ...headers,
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(timeoutDuration);

      print('📡 Applications Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['applications']);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to get applications');
      }
    } catch (e) {
      print('❌ Get Applications Error: $e');
      throw Exception('Failed to get applications: $e');
    }
  }

  // Grama Niladhari Contact endpoints
  static Future<List<Map<String, dynamic>>> getGramaNiladhariByDistrict({
    required String token,
    required String district,
  }) async {
    try {
      print('🔍 Getting Grama Niladhari officials for district: $district');

      final response = await http
          .get(
            Uri.parse('$baseUrl/api/grama-niladhari/district/$district'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(timeoutDuration);

      print('📡 Grama Niladhari Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['grama_niladhari_officials']);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to fetch officials');
      }
    } catch (e) {
      print('❌ Grama Niladhari Error: $e');
      throw Exception('Network error: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> searchGramaNiladhari({
    required String token,
    String? district,
    String? division,
    String? name,
  }) async {
    try {
      print('🔍 Searching Grama Niladhari officials');

      final queryParams = <String, String>{};
      if (district != null && district.isNotEmpty) queryParams['district'] = district;
      if (division != null && division.isNotEmpty) queryParams['division'] = division;
      if (name != null && name.isNotEmpty) queryParams['name'] = name;

      final uri = Uri.parse('$baseUrl/api/grama-niladhari/search')
          .replace(queryParameters: queryParams);

      final response = await http
          .get(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(timeoutDuration);

      print('📡 Grama Niladhari Search Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['grama_niladhari_officials']);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Search failed');
      }
    } catch (e) {
      print('❌ Grama Niladhari Search Error: $e');
      throw Exception('Network error: $e');
    }
  }
}
