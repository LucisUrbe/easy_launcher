import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_launcher/constants/global.dart' as global;
import 'package:easy_launcher/constants/rel.dart';
import 'package:url_launcher/url_launcher.dart';

List<List<Tooltip>> buildPosts(List<RelPost> posts) {
  List<Tooltip> tipAnnounce = <Tooltip>[];
  List<Tooltip> tipInfo = <Tooltip>[];
  List<Tooltip> tipActivity = <Tooltip>[];
  for (final p in posts) {
    Tooltip t = Tooltip(
      waitDuration: const Duration(milliseconds: global.iWaitMS),
      message: p.title,
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: "   ${p.date}   ", // it is a TEMPORARY way to align
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
            TextSpan(
              text: p.title,
              style: const TextStyle(
                color: Colors.white,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  if (!await launchUrl(Uri.parse(p.link))) {
                    throw Exception('Could not launch ${p.link}');
                  }
                },
            ),
          ],
        ),
      ),
    );
    if (p.type == PostType.announce &&
        tipAnnounce.length < global.iMaxPosts) {
      tipAnnounce.add(t);
    } else if (p.type == PostType.info && tipInfo.length < global.iMaxPosts) {
      tipInfo.add(t);
    } else if (p.type == PostType.activity &&
        tipActivity.length < global.iMaxPosts) {
      tipActivity.add(t);
    }
  }
  return <List<Tooltip>>[
    tipAnnounce,
    tipInfo,
    tipActivity,
  ];
}
