import 'package:flutter/material.dart';
import 'package:easy_launcher/generated/l10n.dart';

Expanded startView() {
  return Expanded(
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        const Image(
          image: AssetImage('lib/assets/background.png'),
          fit: BoxFit.fill,
        ),
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
        const Text("IT WORKS"),
      ],
    ),
  );
}
