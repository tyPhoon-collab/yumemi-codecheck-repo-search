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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Github Repos Search`
  String get title {
    return Intl.message(
      'Github Repos Search',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Search Repositories`
  String get searchPlaceholder {
    return Intl.message(
      'Search Repositories',
      name: 'searchPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResults {
    return Intl.message(
      'No results found',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Failed to launch {url}`
  String failedLaunch(Object url) {
    return Intl.message(
      'Failed to launch $url',
      name: 'failedLaunch',
      desc: '',
      args: [url],
    );
  }

  /// `Unexpected error occurred`
  String get errorUnexpected {
    return Intl.message(
      'Unexpected error occurred',
      name: 'errorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `GitHub service is temporarily unavailable`
  String get errorServiceUnavailable {
    return Intl.message(
      'GitHub service is temporarily unavailable',
      name: 'errorServiceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get errorNoInternet {
    return Intl.message(
      'No internet connection',
      name: 'errorNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Validation failed, or the endpoint has been spammed.`
  String get errorValidation {
    return Intl.message(
      'Validation failed, or the endpoint has been spammed.',
      name: 'errorValidation',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
