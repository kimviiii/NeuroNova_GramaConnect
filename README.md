# GramaConnect - Flutter Mobile App

GramaConnect is a mobile application that serves as a digital gateway to Grama Niladhari services in Sri Lanka. It allows citizens to access government services, submit complaints, and stay updated with official announcements.

## Features

### 🌐 Multi-Language Support
- **English** - Full application support
- **සිංහල (Sinhala)** - Complete localization for Sinhala users
- **தமிழ் (Tamil)** - Full Tamil language support

### 🏛️ Government Services
- **Birth Certificate** - Apply online for birth certificates
- **Character Certificate** - Request character certificates
- **Income Certificate** - Apply for income verification
- **Residence Certificate** - Get residence proof documents
- **Application Tracking** - Track your application status

### 📱 Core Features
- **User Authentication** - Secure login and registration
- **Dashboard** - Quick access to services and recent updates
- **Complaints System** - Submit and track complaints
- **Announcements** - Stay updated with official notifications
- **Profile Management** - Manage personal information and settings

### 🎨 User Experience
- **Dark/Light Theme** - Choose your preferred theme or use system settings
- **Responsive Design** - Works perfectly on all screen sizes
- **Offline Support** - Basic functionality even without internet
- **Intuitive Navigation** - Easy-to-use bottom navigation

## Technical Stack

- **Framework**: Flutter 3.32.8
- **Language**: Dart 3.8.1
- **State Management**: Provider Pattern
- **Internationalization**: Flutter Intl
- **HTTP Client**: http package
- **Local Storage**: SharedPreferences
- **UI Components**: Material Design 3

## Prerequisites

Before running this application, make sure you have:

- **Flutter SDK** (3.10.0 or higher)
- **Dart SDK** (3.8.1 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/gramaconnect-flutter.git
   cd gramaconnect-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## Demo Credentials

For testing purposes, you can use these demo credentials:

- **Email**: `demo@gramaconnect.lk`
- **Password**: `demo123`

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   └── user.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── language_provider.dart
│   └── theme_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── auth/
│   │   └── login_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── services/
│   │   └── services_screen.dart
│   ├── complaints/
│   │   └── complaints_screen.dart
│   ├── announcements/
│   │   └── announcements_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── services/                 # API and business logic
│   └── api_service.dart
└── utils/                    # Utilities and helpers
    ├── app_localizations.dart
    └── theme.dart

assets/
├── l10n/                     # Localization files
│   ├── en.json
│   ├── si.json
│   └── ta.json
└── images/                   # App images and icons
```

## Localization

The app supports three languages with complete translations:

- **English (en)**: Default language
- **Sinhala (si)**: Full Sinhala translation
- **Tamil (ta)**: Complete Tamil localization

Localization files are located in `assets/l10n/` directory.

## Theme Support

The application supports multiple theme modes:
- **Light Theme**: Clean and bright interface
- **Dark Theme**: Easy on the eyes for low-light usage
- **System Theme**: Automatically follows system preference

## API Integration

The app is designed to work with a REST API backend. Currently, it includes mock data for demonstration. To connect to a real backend:

1. Update the `baseUrl` in `lib/services/api_service.dart`
2. Implement proper error handling
3. Add authentication tokens for secure endpoints

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Contributing

We welcome contributions to improve GramaConnect. Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Government Partnership

This application is developed to serve the citizens of Sri Lanka in partnership with the Government of Sri Lanka and local Grama Niladhari offices.

## Support

For technical support or questions:
- Email: support@gramaconnect.lk
- Phone: +94 11 xxx xxxx
- Website: https://gramaconnect.gov.lk

## Acknowledgments

- Government of Sri Lanka for digital service initiatives
- Flutter team for the amazing framework
- Community contributors and testers

---

**GramaConnect** - Bridging citizens and government services through technology 🇱🇰
