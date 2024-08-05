import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/policy.dart';

class PolicyService {
  final String baseUrl = 'https://pas-rust.vercel.app/api/public/policies';

  Future<Policy?> fetchPolicy(String policyNumber, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$policyNumber'),
      headers: {
        'Authorization': 'Bearer yJ45fJ234lK8jH765uI90o876t5r4321eR',
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Print the response
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      if (decodedJson.containsKey('policy')) {
        return Policy.fromJson(decodedJson['policy']);
      } else {
        print('Policy key not found in the response.');
        return null;
      }
    } else {
      print('Failed to load policy');
      return null;
    }
  }
}