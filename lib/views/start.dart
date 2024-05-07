import 'package:flutter/material.dart';
import 'package:easy_launcher/generated/l10n.dart';

Expanded startView(BuildContext context) {
  return Expanded(
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        Container(
          width: 90,
          height: 90,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
        Text(S.of(context).launchGame),
      ],
    ),
  );
}
