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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Clear History`
  String get clearHistory {
    return Intl.message(
      'Clear History',
      name: 'clearHistory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear the history?`
  String get clearHistoryConfirm {
    return Intl.message(
      'Are you sure you want to clear the history?',
      name: 'clearHistoryConfirm',
      desc: '',
      args: [],
    );
  }

  /// `History cleared successfully`
  String get clearHistorySuccess {
    return Intl.message(
      'History cleared successfully',
      name: 'clearHistorySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `This app is a GitHub Repository Search API wrapper.\n\nFor yumemi codecheck.`
  String get description {
    return Intl.message(
      'This app is a GitHub Repository Search API wrapper.\n\nFor yumemi codecheck.',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch query history`
  String get errorFetchQueryHistory {
    return Intl.message(
      'Failed to fetch query history',
      name: 'errorFetchQueryHistory',
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

  /// `GitHub service is temporarily unavailable`
  String get errorServiceUnavailable {
    return Intl.message(
      'GitHub service is temporarily unavailable',
      name: 'errorServiceUnavailable',
      desc: '',
      args: [],
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

  /// `Validation failed, or the endpoint has been spammed.`
  String get errorValidation {
    return Intl.message(
      'Validation failed, or the endpoint has been spammed.',
      name: 'errorValidation',
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

  /// `Page: 1 ~ {maxPage}`
  String inputPageNumberDialogHint(Object maxPage) {
    return Intl.message(
      'Page: 1 ~ $maxPage',
      name: 'inputPageNumberDialogHint',
      desc: '',
      args: [maxPage],
    );
  }

  /// `Input page number`
  String get inputPageNumberDialogTitle {
    return Intl.message(
      'Input page number',
      name: 'inputPageNumberDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
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

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `{lower} ~ {upper} of {total}`
  String resultCount(Object lower, Object upper, Object total) {
    return Intl.message(
      '$lower ~ $upper of $total',
      name: 'resultCount',
      desc: '',
      args: [lower, upper, total],
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

  /// `Sort by: `
  String get sortBy {
    return Intl.message(
      'Sort by: ',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Best Match`
  String get sortTypeBestMatch {
    return Intl.message(
      'Best Match',
      name: 'sortTypeBestMatch',
      desc: '',
      args: [],
    );
  }

  /// `Forks`
  String get sortTypeForks {
    return Intl.message(
      'Forks',
      name: 'sortTypeForks',
      desc: '',
      args: [],
    );
  }

  /// `Help Wanted Issues`
  String get sortTypeHelpWantedIssues {
    return Intl.message(
      'Help Wanted Issues',
      name: 'sortTypeHelpWantedIssues',
      desc: '',
      args: [],
    );
  }

  /// `Stars`
  String get sortTypeStars {
    return Intl.message(
      'Stars',
      name: 'sortTypeStars',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get sortTypeUpdated {
    return Intl.message(
      'Updated',
      name: 'sortTypeUpdated',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
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

  /// `Page number is out of range`
  String get validationPageNumberIsOutOfRange {
    return Intl.message(
      'Page number is out of range',
      name: 'validationPageNumberIsOutOfRange',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a number`
  String get validationPleaseEnterANumber {
    return Intl.message(
      'Please enter a number',
      name: 'validationPleaseEnterANumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get validationPleaseEnterAValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'validationPleaseEnterAValidNumber',
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
