import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality
import 'sign_in_page.dart';

class PolicyNumberPage extends StatelessWidget {
  final TextEditingController _policyNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Policy Number',
          style: Theme.of(context).appBarTheme.titleTextStyle, // Use theme-defined text style
        ),
        // AppBar background and icon colors are defined in the theme
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding for the body
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600), // Max width of 600px
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use min size to center content
              children: [
                _buildPolicyInputSection(context),
                SizedBox(height: 40), // Clearance of 40px from the AppBar
                _buildSamplePoliciesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyInputSection(BuildContext context) {
    return Card(
      color: Colors.white, // Card background color
      elevation: 4, // Optional elevation for card shadow
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure items fill the container
          children: [
            TextField(
              controller: _policyNumberController,
              decoration: InputDecoration(
                labelText: 'Policy Number',
                border: OutlineInputBorder(), // Add border to the TextField
              ),
              keyboardType: TextInputType.number, // Ensure numeric keyboard
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String policyNumber = _policyNumberController.text;
                if (policyNumber.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please enter a policy number.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(policyNumber: policyNumber),
                  ),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSamplePoliciesSection() {
    return Card(
      color: Colors.grey[200], // Card background color
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sample Policies',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            _buildSamplePolicyRow('CON345678', 'Show Survey'),
            SizedBox(height: 8.0),
            _buildSamplePolicyRow('CON456789', 'Don\'t Show Survey'),
          ],
        ),
      ),
    );
  }

  Widget _buildSamplePolicyRow(String policyNumber, String surveyText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(policyNumber, style: TextStyle(fontSize: 18.0)),
            SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: policyNumber));
                // Optionally show feedback here
              },
            ),
          ],
        ),
        Text(surveyText, style: TextStyle(fontSize: 18.0)),
      ],
    );
  }
}
