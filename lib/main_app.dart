import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl_standalone.dart';

import 'generated/l10n.dart';
import 'main_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: findSystemLocale(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          Locale locale = const Locale("en");
          if (snapshot.data!.startsWith("zh")) { // zh_Hans_CN
            locale = const Locale("zh");
          }
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: "easy_launcher",
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            ),
            home: const MainPage(),
            locale: locale,
          );
        }
        return const MaterialApp();
      },
    );
  }
}
