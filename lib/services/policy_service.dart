import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/policy.dart';

class PolicyService {
  final String baseUrl = 'https://pas-rust.vercel.app/api/public/policies';

  Future<Policy?> fetchPolicy(String policyNumber, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$policyNumber'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Policy.fromJson(json.decode(response.body));
    } else {
      print('Failed to load policy');
      return null;
    }
  }
}
