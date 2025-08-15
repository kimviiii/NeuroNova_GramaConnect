import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Common translations
  String get appName => translate('app_name');
  String get login => translate('login');
  String get logout => translate('logout');
  String get register => translate('register');
  String get home => translate('home');
  String get services => translate('services');
  String get complaints => translate('complaints');
  String get announcements => translate('announcements');
  String get profile => translate('profile');
  String get settings => translate('settings');
  String get language => translate('language');
  String get theme => translate('theme');
  String get lightTheme => translate('light_theme');
  String get darkTheme => translate('dark_theme');
  String get systemTheme => translate('system_theme');
  String get email => translate('email');
  String get password => translate('password');
  String get name => translate('name');
  String get phone => translate('phone');
  String get address => translate('address');
  String get nic => translate('nic');
  String get submit => translate('submit');
  String get cancel => translate('cancel');
  String get save => translate('save');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get view => translate('view');
  String get search => translate('search');
  String get filter => translate('filter');
  String get sort => translate('sort');
  String get loading => translate('loading');
  String get error => translate('error');
  String get success => translate('success');
  String get warning => translate('warning');
  String get info => translate('info');

  // Service related
  String get birthCertificate => translate('birth_certificate');
  String get characterCertificate => translate('character_certificate');
  String get incomeCertificate => translate('income_certificate');
  String get residenceCertificate => translate('residence_certificate');
  String get applicationForm => translate('application_form');
  String get documentUpload => translate('document_upload');
  String get applicationStatus => translate('application_status');
  String get paymentDetails => translate('payment_details');
  String get marriageCertificate => translate('marriage_certificate');
  String get voterRegistration => translate('voter_registration');

  // Complaint related
  String get submitComplaint => translate('submit_complaint');
  String get complaintTitle => translate('complaint_title');
  String get complaintDescription => translate('complaint_description');
  String get complaintStatus => translate('complaint_status');
  String get complaintPending => translate('complaint_pending');
  String get complaintInProgress => translate('complaint_in_progress');
  String get complaintResolved => translate('complaint_resolved');

  // Validation messages
  String get fieldRequired => translate('field_required');
  String get invalidEmail => translate('invalid_email');
  String get invalidPhone => translate('invalid_phone');
  String get passwordTooShort => translate('password_too_short');
  String get passwordsDoNotMatch => translate('passwords_do_not_match');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'si', 'ta'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
