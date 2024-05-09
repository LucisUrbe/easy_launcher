import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_launcher/generated/l10n.dart';

Expanded startView(BuildContext context) {
  return Expanded(
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Positioned(
          right: 100.0,
          bottom: 80.0,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 100.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)),
                  child: Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).launchGame,
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
