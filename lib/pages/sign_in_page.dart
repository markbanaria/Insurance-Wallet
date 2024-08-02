import 'package:flutter/material.dart';
import 'policy_page.dart';
import '../services/google_sign_in_service.dart';

class SignInPage extends StatelessWidget {
  final String policyNumber;
  SignInPage({required this.policyNumber});

  final GoogleSignInService _googleSignInService = GoogleSignInService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Sign in with Google to continue'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>? user = await _googleSignInService.signInWithGoogle();
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolicyPage(
                        policyNumber: policyNumber,
                        token: user['token'],
                        user: user,
                      ),
                    ),
                  );
                }
              },
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
