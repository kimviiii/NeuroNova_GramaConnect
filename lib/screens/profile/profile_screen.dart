import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final user = Provider.of<AuthProvider>(context).user;

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
        title: Text(localizations?.profile ?? 'Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // Handle edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        user?.name.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.name ?? 'User',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        user?.role.toUpperCase() ?? 'CITIZEN',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Personal Information
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outlined),
                    title: Text(localizations?.name ?? 'Name'),
                    subtitle: Text(user?.name ?? 'Not provided'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle edit name
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: Text(localizations?.email ?? 'Email'),
                    subtitle: Text(user?.email ?? 'Not provided'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle edit email
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: Text(localizations?.phone ?? 'Phone'),
                    subtitle: Text(user?.phone ?? 'Not provided'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle edit phone
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.credit_card_outlined),
                    title: Text(localizations?.nic ?? 'NIC'),
                    subtitle: Text(user?.nic ?? 'Not provided'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle edit NIC
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(localizations?.address ?? 'Address'),
                    subtitle: Text(user?.address ?? 'Not provided'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle edit address
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Settings
            Card(
              child: Column(
                children: [
                  // Language Setting
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return ListTile(
                        leading: const Icon(Icons.language_outlined),
                        title: Text(localizations?.language ?? 'Language'),
                        subtitle: Text(languageProvider.getLanguageName()),
                        trailing: DropdownButton<Locale>(
                          value: languageProvider.currentLocale,
                          underline: Container(),
                          onChanged: (Locale? newLocale) {
                            if (newLocale != null) {
                              languageProvider.changeLanguage(newLocale);
                            }
                          },
                          items: LanguageProvider.supportedLocales.entries
                              .map<DropdownMenuItem<Locale>>((entry) {
                            return DropdownMenuItem<Locale>(
                              value: entry.value,
                              child: Text(entry.key),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),

                  // Theme Setting
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return ListTile(
                        leading: const Icon(Icons.palette_outlined),
                        title: Text(localizations?.theme ?? 'Theme'),
                        subtitle: Text(_getThemeName(
                            themeProvider.themeMode, localizations)),
                        trailing: DropdownButton<ThemeMode>(
                          value: themeProvider.themeMode,
                          underline: Container(),
                          onChanged: (ThemeMode? newMode) {
                            if (newMode != null) {
                              themeProvider.setThemeMode(newMode);
                            }
                          },
                          items: [
                            DropdownMenuItem(
                              value: ThemeMode.light,
                              child: Text(localizations?.lightTheme ?? 'Light'),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.dark,
                              child: Text(localizations?.darkTheme ?? 'Dark'),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.system,
                              child:
                                  Text(localizations?.systemTheme ?? 'System'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),

                  // Notifications
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: const Text('Notifications'),
                    subtitle: const Text('Manage notification preferences'),
                    trailing: Switch(
                      value: true, // This should be managed by a provider
                      onChanged: (value) {
                        // Handle notification toggle
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // App Information
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle help
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.policy_outlined),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle privacy policy
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context, localizations);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(localizations?.logout ?? 'Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeName(ThemeMode mode, AppLocalizations? localizations) {
    switch (mode) {
      case ThemeMode.light:
        return localizations?.lightTheme ?? 'Light';
      case ThemeMode.dark:
        return localizations?.darkTheme ?? 'Dark';
      case ThemeMode.system:
        return localizations?.systemTheme ?? 'System';
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'GramaConnect',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Government of Sri Lanka',
      children: [
        const SizedBox(height: 16),
        const Text(
          'GramaConnect is your gateway to Grama Niladhari services. Access government services, submit complaints, and stay updated with announcements.',
        ),
      ],
    );
  }

  void _showLogoutDialog(
      BuildContext context, AppLocalizations? localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations?.logout ?? 'Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Text(localizations?.logout ?? 'Logout'),
          ),
        ],
      ),
    );
  }
}
