import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/views/start.dart';
import 'package:easy_launcher/utils/remote_api.dart';

class MainPage extends StatefulWidget {
  final Locale locale;
  const MainPage({
    super.key,
    required this.locale,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getRemoteContent(widget.locale),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        StartPage sp = const StartPage(content: {});
        if (snapshot.hasData) {
          Map<String, dynamic> map =
              json.decode(utf8.decode(snapshot.data!.codeUnits));
          sp = StartPage(content: map);
        }
        if (snapshot.hasError) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                  tileMode: TileMode.clamp,
                ),
                child: Container(
                  width: 400.0,
                  height: 200.0,
                  decoration: const BoxDecoration(color: Colors.black12),
                  child: Center(
                    child: Text(
                      S.of(context).remoteFailed,
                      style: const TextStyle(
                        inherit: false,
                        color: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return sp;
      },
    );
  }
}
