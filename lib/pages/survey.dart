import 'dart:convert'; // Import this to use jsonEncode and jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_cx_nps_survey/flutter_cx_nps_survey.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  Map<String, dynamic>? _templates;
  SurveyConfig? _surveyConfig;
  String _selectedTemplate = 'NPS'; // Default template
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    try {
      final String response = await rootBundle.loadString('assets/survey_templates.json');
      final Map<String, dynamic> data = jsonDecode(response);

      setState(() {
        _templates = data;
        _updateSurveyConfig();
      });
    } catch (e) {
      print('Failed to load survey templates: $e');
    }
  }

  void _updateSurveyConfig() {
    if (_templates != null) {
      final template = _templates![_selectedTemplate];
      if (template != null) {
        setState(() {
          _surveyConfig = SurveyConfig(
            title: template['title'],
            description: template['description'],
            questions: (template['questions'] as List<dynamic>).map((q) {
              return SurveyQuestion(
                question: q['question'],
                inputType: InputType.values.byName(q['inputType']),
                options: (q['options'] as List<dynamic>?)?.cast<String>(),
                maxRating: q['maxRating']?.toInt(),
                minSliderValue: q['minSliderValue']?.toDouble(),
                maxSliderValue: q['maxSliderValue']?.toDouble(),
              );
            }).toList(),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: _surveyConfig == null
              ? CircularProgressIndicator() // Show loading spinner while fetching config
              : Column(
                  children: [
                    // Survey template selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTemplateSelector('NPS'),
                        _buildTemplateSelector('CSAT'),
                        _buildTemplateSelector('Custom'),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Survey form
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              SurveyForm(
                                config: _surveyConfig!,
                                submissionConfig: jsonSubmissionConfig(
                                  url: 'https://pas-rust.vercel.app/api/public/customers/postfeedbackresponse',
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
                                    Navigator.of(context).pop(true);
                                  },
                                  onError: (error) {
                                    setState(() {
                                      _isSubmitting = false;
                                    });
                                    Navigator.of(context).pop(false);
                                  },
                                ),
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
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateSelector(String templateName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Text(templateName),
        selected: _selectedTemplate == templateName,
        selectedColor: Colors.red,
        backgroundColor: Colors.transparent,
        disabledColor: Colors.transparent,
        labelStyle: TextStyle(
          color: _selectedTemplate == templateName ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        side: BorderSide(
          color: _selectedTemplate == templateName ? Colors.red : Colors.black,
          width: 2,
        ),
        onSelected: (selected) {
          setState(() {
            _selectedTemplate = templateName;
            _updateSurveyConfig();
          });
        },
      ),
    );
  }
}
