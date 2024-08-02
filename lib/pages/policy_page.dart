import 'package:flutter/material.dart';
import '../models/policy.dart';
import '../services/policy_service.dart';

class PolicyPage extends StatefulWidget {
  final String policyNumber;
  final String token;
  final Map<String, dynamic> user;  // Add this line

  PolicyPage({required this.policyNumber, required this.token, required this.user});  // Update this line

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
            Policy policy = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserCard(widget.user),
                  SizedBox(height: 20),
                  _buildCard('Customer Information', _buildCustomerInfo(policy.customer)),
                  SizedBox(height: 20),
                  _buildCard('Contract Details', _buildContractInfo(policy.contract)),
                  SizedBox(height: 20),
                  _buildCard('Coverages', _buildCoveragesTable(policy.risks)),
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
        Text('Name: ${customer.name}'),
        Text('Email: ${customer.contact.email}'),
        Text('Phone: ${customer.contact.phone}'),
        Text('Address: ${customer.address.street}, ${customer.address.city}, ${customer.address.state}, ${customer.address.zipCode}, ${customer.address.country}'),
      ],
    );
  }

  Widget _buildContractInfo(Contract contract) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contract ID: ${contract.contractId}'),
        Text('Premium: ${contract.premium.amount} ${contract.premium.currency} (${contract.premium.billingType})'),
        Text('Plan: ${contract.planSelection}'),
        Text('Start Date: ${contract.startDate}'),
        Text('End Date: ${contract.endDate}'),
        Text('Coverage Type: ${contract.coverageType}'),
      ],
    );
  }

  Widget _buildCoveragesTable(List<Risk> risks) {
    return Column(
      children: risks.map((risk) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plan Type: ${risk.planType}', style: TextStyle(fontWeight: FontWeight.bold)),
            DataTable(
              columns: [
                DataColumn(label: Text('Benefit')),
                DataColumn(label: Text('Limit')),
                DataColumn(label: Text('Deductible')),
              ],
              rows: risk.benefits.map((benefit) {
                return DataRow(
                  cells: [
                    DataCell(Text(benefit.name)),
                    DataCell(Text('${benefit.limit.amount} ${benefit.limit.currency}')),
                    DataCell(Text('${benefit.deductible.amount} ${benefit.deductible.currency}')),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
