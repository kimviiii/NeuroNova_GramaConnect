import 'package:flutter/material.dart';
import '../../utils/app_localizations.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.services ?? 'Services'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ServiceCard(
            icon: Icons.article_outlined,
            title: localizations?.birthCertificate ?? 'Birth Certificate',
            description: 'Apply for a new birth certificate',
            fee: 'LKR 500',
            color: Colors.blue,
            onTap: () {
              // Handle service selection
            },
          ),
          _ServiceCard(
            icon: Icons.verified_outlined,
            title:
                localizations?.characterCertificate ?? 'Character Certificate',
            description: 'Apply for a character certificate',
            fee: 'LKR 300',
            color: Colors.green,
            onTap: () {
              // Handle service selection
            },
          ),
          _ServiceCard(
            icon: Icons.money_outlined,
            title: localizations?.incomeCertificate ?? 'Income Certificate',
            description: 'Apply for an income certificate',
            fee: 'LKR 200',
            color: Colors.orange,
            onTap: () {
              // Handle service selection
            },
          ),
          _ServiceCard(
            icon: Icons.home_outlined,
            title:
                localizations?.residenceCertificate ?? 'Residence Certificate',
            description: 'Apply for a residence certificate',
            fee: 'LKR 250',
            color: Colors.purple,
            onTap: () {
              // Handle service selection
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String fee;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.fee,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Text(
              'Fee: $fee',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
        isThreeLine: true,
      ),
    );
  }
}
