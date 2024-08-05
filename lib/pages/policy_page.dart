import 'package:flutter/material.dart';
import '../models/policy.dart';
import '../services/policy_service.dart';

class PolicyPage extends StatefulWidget {
  final String policyNumber;
  final String token;
  final Map<String, dynamic> user;

  PolicyPage({required this.policyNumber, required this.token, required this.user});

  @override
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  late Future<Policy?> _policy;

  @override
  void initState() {
    super.initState();
    _policy = PolicyService().fetchPolicy(widget.policyNumber, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy Details'),
      ),
      body: FutureBuilder<Policy?>(
        future: _policy,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No policy found.'));
          } else {
            Policy? policy = snapshot.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserCard(widget.user),
                  SizedBox(height: 20),
                  if (policy?.customer != null) _buildCard('Customer Information', _buildCustomerInfo(policy!.customer!)),
                  SizedBox(height: 20),
                  if (policy?.contract != null) _buildCard('Contract Details', _buildContractInfo(policy!.contract!)),
                  SizedBox(height: 20),
                  if (policy?.risks != null) _buildCard('Coverages', _buildCoveragesTable(policy!.risks!)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user['image']),
              radius: 30,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(user['email']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, Widget content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfo(Customer customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name: ${customer.name ?? 'N/A'}'),
        Text('Email: ${customer.contact?.email ?? 'N/A'}'),
        Text('Phone: ${customer.contact?.phone ?? 'N/A'}'),
        Text('Address: ${customer.address?.street ?? 'N/A'}, ${customer.address?.city ?? 'N/A'}, ${customer.address?.state ?? 'N/A'}, ${customer.address?.zipCode ?? 'N/A'}, ${customer.address?.country ?? 'N/A'}'),
        Text('Date of Birth: ${customer.dateOfBirth ?? 'N/A'}'),
        Text('Gender: ${customer.gender ?? 'N/A'}'),
      ],
    );
  }

  Widget _buildContractInfo(Contract contract) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contract ID: ${contract.contractId ?? 'N/A'}'),
        Text('Premium: ${contract.premium?.amount?.toString() ?? 'N/A'} ${contract.premium?.currency ?? 'N/A'} (${contract.premium?.billingType ?? 'N/A'})'),
        Text('Plan: ${contract.planSelection ?? 'N/A'}'),
        Text('Start Date: ${contract.startDate ?? 'N/A'}'),
        Text('End Date: ${contract.endDate ?? 'N/A'}'),
        Text('Coverage Type: ${contract.coverageType ?? 'N/A'}'),
        Text('Campaign: ${contract.campaign ?? 'N/A'}'),
      ],
    );
  }

  Widget _buildCoveragesTable(List<Risk> risks) {
    return Column(
      children: risks.map((risk) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plan Type: ${risk.planType ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold)),
            DataTable(
              columns: [
                DataColumn(label: Text('Benefit')),
                DataColumn(label: Text('Limit')),
                DataColumn(label: Text('Deductible')),
              ],
              rows: risk.benefits?.map((benefit) {
                return DataRow(
                  cells: [
                    DataCell(Text(benefit.name ?? 'N/A')),
                    DataCell(Text('${benefit.limit?.amount?.toString() ?? 'N/A'} ${benefit.limit?.currency ?? 'N/A'}')),
                    DataCell(Text('${benefit.deductible?.amount?.toString() ?? 'N/A'} ${benefit.deductible?.currency ?? 'N/A'}')),
                  ],
                );
              }).toList() ?? [],
            ),
          ],
        );
      }).toList(),
    );
  }
}
