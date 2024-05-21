import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckboxListTile(
          hoverColor: Colors.grey,
          activeColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: true,
          onChanged: (bool? value) {
            // setState(() {});
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
          value: true,
          onChanged: (bool? value) {
            // setState(() {});
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
        CheckboxListTile(
          hoverColor: Colors.grey,
          activeColor: Colors.black,
          controlAffinity: ListTileControlAffinity.leading,
          value: true,
          onChanged: (bool? value) {
            // setState(() {});
          },
          title: Text(
            S.of(context).languageCodeTitle,
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            S.of(context).languageCodeSubtitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
