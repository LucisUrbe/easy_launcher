import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_launcher/views/start.dart';
import 'package:easy_launcher/utils/remote_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getRemoteContent(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        StartPage sp = const StartPage(
          content: {},
        );
        if (snapshot.hasData) {
          Map<String, dynamic> map = json.decode(
            utf8.decode(
              snapshot.data!.codeUnits,
            ),
          );
          sp = StartPage(
            content: map,
          );
        }
        return sp;
      },
    );
  }
}
