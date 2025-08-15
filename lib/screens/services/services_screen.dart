import 'package:flutter/material.dart';
import '../../utils/app_localizations.dart';
import 'marriage_certificate_screen.dart';
import 'character_certificate_screen.dart';
import 'voter_registration_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(localizations?.services ?? 'Services'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ServiceCard(
            icon: Icons.favorite_outlined,
            title: 'Marriage Certificate',
            description: 'Apply for an official marriage certificate',
            fee: 'LKR 1,000',
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarriageCertificateScreen(),
                ),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CharacterCertificateScreen(),
                ),
              );
            },
          ),
          _ServiceCard(
            icon: Icons.how_to_vote_outlined,
            title: 'Voter Registration Update',
            description: 'Update voter registration details',
            fee: 'Free',
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VoterRegistrationScreen(),
                ),
              );
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
