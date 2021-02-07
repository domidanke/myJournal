// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MyJournal`
  String get welcomeScreenAppName {
    return Intl.message(
      'MyJournal',
      name: 'welcomeScreenAppName',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get welcomeScreenLoginButton {
    return Intl.message(
      'Log In',
      name: 'welcomeScreenLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get welcomeScreenRegistrationButton {
    return Intl.message(
      'Register',
      name: 'welcomeScreenRegistrationButton',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get welcomeScreenForgotPasswordButton {
    return Intl.message(
      'Forgot your password?',
      name: 'welcomeScreenForgotPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get welcomeScreenEmailTextFieldHint {
    return Intl.message(
      'Enter your email',
      name: 'welcomeScreenEmailTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get welcomeScreenPasswordTextFieldHint {
    return Intl.message(
      'Enter your password',
      name: 'welcomeScreenPasswordTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get loginScreenErrorInvalidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'loginScreenErrorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, we can't find an account with this email address.`
  String get loginScreenErrorUserNotFound {
    return Intl.message(
      'Sorry, we can\'t find an account with this email address.',
      name: 'loginScreenErrorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Email or password is invalid. Please try again.`
  String get loginScreenErrorWrongPassword {
    return Intl.message(
      'Email or password is invalid. Please try again.',
      name: 'loginScreenErrorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get loginScreenErrorDefault {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'loginScreenErrorDefault',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get loginScreenErrorTitle {
    return Intl.message(
      'Login failed',
      name: 'loginScreenErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registrationScreenTopLabel {
    return Intl.message(
      'Register',
      name: 'registrationScreenTopLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get registrationScreenEmailTextFieldHint {
    return Intl.message(
      'Enter your email',
      name: 'registrationScreenEmailTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get registrationScreenPasswordTextFieldHint {
    return Intl.message(
      'Enter your password',
      name: 'registrationScreenPasswordTextFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registrationScreenRegistrationButton {
    return Intl.message(
      'Register',
      name: 'registrationScreenRegistrationButton',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get registrationScreenBackToLoginButton {
    return Intl.message(
      'Back to Login',
      name: 'registrationScreenBackToLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get registrationScreenErrorInvalidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'registrationScreenErrorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `The password must be at least 6 characters long.`
  String get registrationScreenErrorWeakPassword {
    return Intl.message(
      'The password must be at least 6 characters long.',
      name: 'registrationScreenErrorWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use by another account.`
  String get registrationScreenErrorEmailAlreadyInUse {
    return Intl.message(
      'The email address is already in use by another account.',
      name: 'registrationScreenErrorEmailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get registrationScreenErrorDefault {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'registrationScreenErrorDefault',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registrationScreenErrorTitle {
    return Intl.message(
      'Registration failed',
      name: 'registrationScreenErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address and password.`
  String get registrationScreenErrorEmptyFields {
    return Intl.message(
      'Please enter a valid email address and password.',
      name: 'registrationScreenErrorEmptyFields',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}