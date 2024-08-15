import 'package:flutter/material.dart';
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart';

class SurveyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the survey configuration
    final surveyConfig = SurveyConfig(
      title: 'Customer Satisfaction Survey',
      description: 'Please answer the following questions to help us improve our service:',
      questions: [
        SurveyQuestion(
          question: 'How satisfied are you with our service?',
          inputType: InputType.radioButton,
          options: ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very Dissatisfied'],
        ),
        SurveyQuestion(
          question: 'Rate the quality of our products',
          inputType: InputType.starRating,
          maxRating: 5,
        ),
        SurveyQuestion(
          question: 'Any additional comments?',
          inputType: InputType.textField,
        ),
      ],
    );

    // Configure the submission for HTTP
    final submissionConfigHttp = SubmissionConfig(
      type: SubmissionType.http,
      url: 'https://pas-rust.vercel.app/api/public/customers/postfeedbackresponse',
      headers: {'Content-Type': 'application/json'},
      bodyBuilder: (data) {
        return data; // Directly use the survey data as the body
      },
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SurveyForm(
          config: surveyConfig,
          submissionConfig: submissionConfigHttp, // You can also use a GraphQL submission config if needed
        ),
      ),
    );
  }
}
