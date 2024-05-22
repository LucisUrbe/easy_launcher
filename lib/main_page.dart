import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_launcher/constants/style.dart' as style;
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
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const StartPage(content: {});
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              Map<String, dynamic> map =
                  json.decode(utf8.decode(snapshot.data!.codeUnits));
              return StartPage(content: map);
            }
            if (snapshot.hasError) {
              return Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(style.dDialogRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: style.dBlurSigma,
                      sigmaY: style.dBlurSigma,
                      tileMode: TileMode.clamp,
                    ),
                    child: Container(
                      width: style.dDialogW,
                      height: style.dDialogH,
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
        }
        return const CircularProgressIndicator(); // When is this called?
      },
    );
  }
}
