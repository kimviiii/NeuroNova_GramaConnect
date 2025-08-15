import 'package:flutter/material.dart';
import 'package:gramaconnect/screens/services/marriage_certificate_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_localizations.dart';
import '../services/services_screen.dart';
import '../complaints/complaints_screen.dart';
import '../announcements/announcements_screen.dart';
import '../profile/profile_screen.dart';
import '../services/character_certificate_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomePage(),
      const ServicesScreen(),
      const ComplaintsScreen(),
      const AnnouncementsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: localizations?.home ?? 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.business_outlined),
            activeIcon: const Icon(Icons.business),
            label: localizations?.services ?? 'Services',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.feedback_outlined),
            activeIcon: const Icon(Icons.feedback),
            label: localizations?.complaints ?? 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.announcement_outlined),
            activeIcon: const Icon(Icons.announcement),
            label: localizations?.announcements ?? 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outlined),
            activeIcon: const Icon(Icons.person),
            label: localizations?.profile ?? 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback? onProfileTap;
  const HomePage({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/logo.png',
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(localizations?.appName ?? 'GramaConnect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            InkWell(
              onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
              child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Text(
                                user?.name.substring(0, 1).toUpperCase() ?? 'U',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${localizations?.translate('welcome_message') ?? 'Welcome'}, ${user?.name ?? 'User'}!',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    localizations?.translate('welcome_subtitle') ??
                                        'Your gateway to Grama Niladhari services',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ), 
                            ),
                          ],
                        ),
                      ),
                      
                    ),
            ),


              
            const SizedBox(height: 24),

            // Quick Services Section
            Text(
              localizations?.translate('quick_services') ?? 'Quick Services',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _QuickServiceCard(
                  icon: Icons.article_outlined,
                  title: localizations?.marriageCertificate ?? 'Marriage Certificate',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarriageCertificateScreen(),
                ),
              );
                  },
                ),
                _QuickServiceCard(
                  icon: Icons.verified_outlined,
                  title: localizations?.characterCertificate ??
                      'Character Certificate',
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
                _QuickServiceCard(
                  icon: Icons.feedback_outlined,
                  title: localizations?.submitComplaint ?? 'Submit Complaint',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, '/complaints');
                  },
                ),
                _QuickServiceCard(
                  icon: Icons.phone_outlined,
                  title: localizations?.translate('contact_grama_niladhari') ??
                      'Contact Office',
                  color: Colors.purple,
                  onTap: () {
                    // Handle contact
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Announcements Section
            Text(
              localizations?.translate('recent_announcements') ??
                  'Recent Announcements',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Icon(Icons.announcement, color: Colors.blue),
                ),
                title: const Text('New Service Available'),
                subtitle: const Text(
                    'Online birth certificate service is now available'),
                trailing: const Text('1d ago'),
                onTap: () {
                  Navigator.pushNamed(context, '/announcements');
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.2),
                  child: Icon(Icons.schedule, color: Colors.green),
                ),
                title: const Text('Office Hours Update'),
                subtitle:
                    const Text('New office hours: Mon-Fri 8:00 AM - 4:00 PM'),
                trailing: const Text('3d ago'),
                onTap: () {
                  Navigator.pushNamed(context, '/announcements');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickServiceCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
