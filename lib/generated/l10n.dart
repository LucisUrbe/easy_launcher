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

  /// `Please wait while loading remote contents.`
  String get remoteLoading {
    return Intl.message(
      'Please wait while loading remote contents.',
      name: 'remoteLoading',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load remote contents.`
  String get remoteFailed {
    return Intl.message(
      'Failed to load remote contents.',
      name: 'remoteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Launch`
  String get launchGame {
    return Intl.message(
      'Launch',
      name: 'launchGame',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get activity {
    return Intl.message(
      'Events',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Notices`
  String get announce {
    return Intl.message(
      'Notices',
      name: 'announce',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Restart App`
  String get restart {
    return Intl.message(
      'Restart App',
      name: 'restart',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Show official banners`
  String get showBannersTitle {
    return Intl.message(
      'Show official banners',
      name: 'showBannersTitle',
      desc: '',
      args: [],
    );
  }

  /// `The banners are a series of images for advertisements.`
  String get showBannersSubtitle {
    return Intl.message(
      'The banners are a series of images for advertisements.',
      name: 'showBannersSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Show official posts`
  String get showPostsTitle {
    return Intl.message(
      'Show official posts',
      name: 'showPostsTitle',
      desc: '',
      args: [],
    );
  }

  /// `The posts are a series of hyperlinks for activities, etc.`
  String get showPostsSubtitle {
    return Intl.message(
      'The posts are a series of hyperlinks for activities, etc.',
      name: 'showPostsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Custom language code`
  String get languageCodeTitle {
    return Intl.message(
      'Custom language code',
      name: 'languageCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `The entries are from officially supported languages.`
  String get languageCodeSubtitle {
    return Intl.message(
      'The entries are from officially supported languages.',
      name: 'languageCodeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `This app uses MiSans as the default font.`
  String get fontExclamation {
    return Intl.message(
      'This app uses MiSans as the default font.',
      name: 'fontExclamation',
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
      Locale.fromSubtags(languageCode: 'zh'),
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
