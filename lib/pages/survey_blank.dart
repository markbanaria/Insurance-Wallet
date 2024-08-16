import 'package:flutter/material.dart';
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart'; // Import your CX package

class SurveyBlankPage extends StatefulWidget {
  @override
  _SurveyBlankPageState createState() => _SurveyBlankPageState();
}

class _SurveyBlankPageState extends State<SurveyBlankPage> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    // Define a simple NPS survey configuration with star rating input
    final SurveyConfig surveyConfig = SurveyConfig(
      title: 'Net Promoter Score Survey',
      description: 'Please rate your experience with our service.',
      questions: [
        SurveyQuestion(
          question: 'How likely are you to recommend our service to a friend or colleague?',
          inputType: InputType.starRating, // Use star rating input for NPS
          maxRating: 10, // NPS usually ranges from 0 to 10
        ),
      ],
    );

    // Define the submission configuration
    final SubmissionConfig<Map<String, dynamic>> submissionConfig = jsonSubmissionConfig(
      url: 'https://your-api-endpoint.com/api/nps/submit', // Replace with your API endpoint
      headers: {'Content-Type': 'application/json'},
      onSubmit: () {
        setState(() {
          _isSubmitting = true;
        });
      },
      onSuccess: () {
        setState(() {
          _isSubmitting = false;
        });
        // Handle success (e.g., show a confirmation message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Survey submitted successfully!')),
        );
      },
      onError: (error) {
        setState(() {
          _isSubmitting = false;
        });
        // Handle error (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit survey: $error')),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Survey'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    // Survey form
                    SurveyForm(
                      config: surveyConfig,
                      submissionConfig: submissionConfig,
                    ),
                    if (_isSubmitting)
                      Center(
                        child: CircularProgressIndicator(), // Spinner during submission
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
