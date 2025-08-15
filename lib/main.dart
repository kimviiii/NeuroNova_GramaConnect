import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gramaconnect/screens/services/marriage_certificate_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/multi_step_register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/services/services_screen.dart';
import 'screens/services/character_certificate_screen.dart';
import 'screens/services/voter_registration_screen.dart';
import 'screens/services/contact_grama_niladhari_screen.dart';
import 'screens/complaints/complaints_screen.dart';
import 'screens/announcements/announcements_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'utils/app_localizations.dart';
import 'utils/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, ThemeProvider>(
      builder: (context, languageProvider, themeProvider, child) {
        return MaterialApp(
          title: 'GramaConnect',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          locale: languageProvider.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'), // English
            Locale('si', 'LK'), // Sinhala
            Locale('ta', 'LK'), // Tamil
          ],
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/register': (context) => const RegisterScreen(),
            '/multi-step-register': (context) =>
                const MultiStepRegisterScreen(),
            '/home': (context) => const HomeScreen(),
            '/services': (context) => const ServicesScreen(),
            '/character-certificate': (context) =>
                const CharacterCertificateScreen(),
            '/voter-registration': (context) =>
                const VoterRegistrationScreen(),
            '/contact-grama-niladhari': (context) =>
                const ContactGramaNiladhariScreen(),
            '/complaints': (context) => const ComplaintsScreen(),
            '/announcements': (context) => const AnnouncementsScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/marriage': (context) => const MarriageCertificateScreen(),
          },
        );
      },
    );
  }
}
