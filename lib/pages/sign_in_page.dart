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
        title: Text(
          'Sign In',
          style: Theme.of(context).appBarTheme.titleTextStyle, // Use theme-defined text style
        ),
        // AppBar background and icon colors are defined in the theme
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600), // Max width of 600px
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center content vertically
              children: [
                Card(
                  color: Colors.white, // Card background color
                  elevation: 4, // Optional elevation for card shadow
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size to center content
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to fill horizontal space
                      children: [
                        Text(
                          'Sign in with Google to continue',
                          style: TextStyle(fontSize: 16.0), // Adjust text style as needed
                          textAlign: TextAlign.center, // Center-align text
                        ),
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
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36), // Fill the width of the card
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between cards
                Card(
                  color: Colors.white, // Card background color
                  elevation: 4, // Optional elevation for card shadow
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use min size to center content
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to fill horizontal space
                      children: [
                        Text(
                          'Test User',
                          style: TextStyle(fontSize: 16.0), // Adjust text style as needed
                          textAlign: TextAlign.center, // Center-align text
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Handle the test button press
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PolicyPage(
                                  policyNumber: policyNumber,
                                  token: 'mock_user_token_12345', // Mock token
                                  user: {
                                    'name': 'John Doe',
                                    'email': 'johndoe@example.com',
                                    'image': 'https://example.com/profile.jpg' // Example image URL
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text('Login as a Test User'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 36), // Fill the width of the card
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
