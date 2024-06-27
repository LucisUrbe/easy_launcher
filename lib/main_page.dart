import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_launcher/constants/global.dart' as style;
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/views/start.dart';
import 'package:easy_launcher/utils/remote_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getRemoteInfo(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const StartPage(content: {});
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return StartPage(content: snapshot.data!);
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
