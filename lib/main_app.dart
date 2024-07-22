import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl_standalone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_launcher/constants/global.dart' as global;
import 'package:easy_launcher/constants/rel.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/main_page.dart';

Locale setGlobalRelIF(String systemLocale, SharedPreferences prefs) {
  Locale locale = const Locale("en");
  if (systemLocale.startsWith("zh")) {
    // zh_Hans_CN
    locale = const Locale("zh");
    global.relIF = CnRelInterface();
    return locale; // Please add this return for special cases!
  }
  global.relIF.language = prefs.getString('languageCode') ?? 'en-us';
  return locale;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        findSystemLocale(),
        SharedPreferences.getInstance(),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          // Set the global locale.
          Locale locale = setGlobalRelIF(
            snapshot.data![0],
            snapshot.data![1],
          );
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: global.sAppTitle,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              navigationRailTheme: NavigationRailThemeData(
                backgroundColor: Colors.grey.shade900,
                groupAlignment: 1.0, // bottom
                labelType: NavigationRailLabelType.all,
                unselectedLabelTextStyle: const TextStyle(
                  color: Colors.grey,
                  backgroundColor: Colors.transparent,
                ),
                selectedLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                ),
                useIndicator: true,
                indicatorColor: Colors.grey[850],
                indicatorShape: const RoundedRectangleBorder(
                  side: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(global.dPostRadius),
                  ),
                ),
              ),
              fontFamily: 'MiSans', // TODO: add an exclamation about this font
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
