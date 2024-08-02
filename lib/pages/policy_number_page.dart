import 'package:flutter/material.dart';
import 'sign_in_page.dart';

class PolicyNumberPage extends StatelessWidget {
  final TextEditingController _policyNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Policy Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _policyNumberController,
              decoration: InputDecoration(
                labelText: 'Policy Number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String policyNumber = _policyNumberController.text;
                // TODO: Validate policy number
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
}
