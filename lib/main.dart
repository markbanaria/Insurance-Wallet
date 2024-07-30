import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Policy Details'),
        ),
        body: PolicyDetails(),
      ),
    );
  }
}

class PolicyDetails extends StatelessWidget {
  final Map<String, dynamic> policy = {
    "policy": {
      "customer": {
        "name": "Alice Johnson",
      },
      "contract": {
        "contract_id": "CON456789",
        "start_date": "2024-08-01",
        "end_date": "2025-07-31",
        "plan_selection": "comprehensive",
        "coverage_type": "individual"
      },
      "risk": [
        {
          "insured": [
            {
              "name": "Alice Johnson",
              "age": 41,
              "relationship": "self",
              "gender": "F"
            }
          ],
          "benefits": [
            {
              "name": "Hospitalization",
              "limit": {
                "amount": 100000,
                "currency": "USD"
              },
              "deductible": {
                "amount": 500,
                "currency": "USD"
              }
            },
            {
              "name": "Outpatient",
              "limit": {
                "amount": 5000,
                "currency": "USD"
              },
              "deductible": {
                "amount": 100,
                "currency": "USD"
              }
            }
          ],
          "optional_benefits": [
            {
              "name": "Dental",
              "selected": true,
              "additional_premium": {
                "amount": 200,
                "currency": "USD"
              }
            },
            {
              "name": "Vision",
              "selected": false,
              "additional_premium": {
                "amount": 150,
                "currency": "USD"
              }
            }
          ]
        }
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer: ${policy['policy']['customer']['name']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Policy ID: ${policy['policy']['contract']['contract_id']}'),
          Text('Start Date: ${policy['policy']['contract']['start_date']}'),
          Text('End Date: ${policy['policy']['contract']['end_date']}'),
          Text('Plan: ${policy['policy']['contract']['plan_selection']}'),
          Text('Coverage Type: ${policy['policy']['contract']['coverage_type']}'),
          SizedBox(height: 20),
          Text(
            'Coverages',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          DataTable(
            columns: [
              DataColumn(label: Text('Coverage')),
              DataColumn(label: Text('Limit')),
              DataColumn(label: Text('Deductible')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Hospitalization')),
                DataCell(Text('\$100,000')),
                DataCell(Text('\$500')),
              ]),
              DataRow(cells: [
                DataCell(Text('Outpatient')),
                DataCell(Text('\$5,000')),
                DataCell(Text('\$100')),
              ]),
              DataRow(cells: [
                DataCell(Text('Dental (Optional)')),
                DataCell(Text('Selected')),
                DataCell(Text('\$200 additional premium')),
              ]),
              DataRow(cells: [
                DataCell(Text('Vision (Optional)')),
                DataCell(Text('Not Selected')),
                DataCell(Text('\$150 additional premium')),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
