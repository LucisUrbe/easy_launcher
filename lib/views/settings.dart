import 'package:easy_launcher/constants/rel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_launcher/constants/style.dart' as style;
import 'package:easy_launcher/generated/l10n.dart';

Future<void> buildSettings(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 100.0,
        vertical: 150.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: Text(S.of(context).settings)),
              const SettingsPage(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(S.of(context).close),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late bool showBanners;
  late bool showPosts;
  late String languageCode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: _prefs,
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            final SharedPreferences prefs = snapshot.data!;
            showBanners = prefs.getBool('showBanners') ?? true;
            showPosts = prefs.getBool('showPosts') ?? true;
            languageCode = prefs.getString('languageCode') ?? 'en-us';
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CheckboxListTile(
                  hoverColor: Colors.grey,
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: showBanners,
                  onChanged: (bool? value) {
                    setState(() {
                      showBanners = value!;
                      prefs.setBool('showBanners', value);
                    });
                  },
                  title: Text(
                    S.of(context).showBannersTitle,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    S.of(context).showBannersSubtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                CheckboxListTile(
                  hoverColor: Colors.grey,
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: showPosts,
                  onChanged: (bool? value) {
                    setState(() {
                      showPosts = value!;
                      prefs.setBool('showPosts', value);
                    });
                  },
                  title: Text(
                    S.of(context).showPostsTitle,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    S.of(context).showPostsSubtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                style.relIF is OsRelInterface
                    ? Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              enabled: false,
                              value: false,
                              hoverColor: Colors.grey,
                              activeColor: Colors.black,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (_) {},
                              title: Text(
                                S.of(context).languageCodeTitle,
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                S.of(context).languageCodeSubtitle,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          DropdownButton(
                            value: languageCode,
                            items: style.supportedLanguage.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? selectedValue) {
                              setState(() {
                                languageCode = selectedValue ?? 'en-us';
                                prefs.setString(
                                  'languageCode',
                                  selectedValue ?? 'en-us',
                                );
                              });
                            },
                          ),
                        ],
                      )
                    : Container(),
              ],
            );
        }
      },
    );
  }
}
