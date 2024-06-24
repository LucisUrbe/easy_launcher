import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_launcher/constants/global.dart' as style;
import 'package:easy_launcher/constants/useful.b91.dart';
import 'package:easy_launcher/constants/rel.dart';

Future<Map<String, dynamic>> getRemoteJSON(
  String url,
  List<String> parameters,
) async {
  final Uri httpPackageUrl = Uri.parse('$url?${parameters.join('&')}');
  final Future<String> httpPackageInfo = http.read(httpPackageUrl);
  return json.decode(utf8.decode((await httpPackageInfo).codeUnits));
}

Future<Map<String, dynamic>> getRemoteInfo(Locale locale) async {
  // Set the interface according to the locale.
  if (locale.languageCode == "zh") {
    style.relIF = CnRelInterface();
  } else {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    style.relIF.language = prefs.getString('languageCode') ?? 'en-us';
  }
  // Assemble the URI and get the response from the Internet.
  String url = UsefulKV.get(style.relIF.useful[0]) +
      UsefulKV.get(style.relIF.useful[2]);
  List<String> parameters = <String>[
    'launcher_id=${UsefulKV.get(style.relIF.useful[1])}',
    'language=${style.relIF.language}',
  ];
  Map<String, dynamic> remoteJSON = await getRemoteJSON(url, parameters);
  if (remoteJSON['retcode'] == 0 && remoteJSON['message'] == 'OK') {
    // Assemble the URI and get the response from the Internet.
    url = UsefulKV.get(style.relIF.useful[0]) +
        UsefulKV.get(style.relIF.useful[3]);
    String gameID = '';
    for (Map<String, dynamic> iL in remoteJSON['data']['game_info_list']) {
      if (iL['game']['biz'] == UsefulKV.get(style.relIF.useful[4])) {
        gameID = iL['game']['id'];
      }
    }
    parameters = <String>[
      'launcher_id=${UsefulKV.get(style.relIF.useful[1])}',
      'game_id=$gameID',
      'language=${style.relIF.language}',
    ];
    // Get another response from the Internet and merge them together.
    Map<String, dynamic> toAdd = await getRemoteJSON(url, parameters);
    if (toAdd['retcode'] == 0 && toAdd['message'] == 'OK') {
      remoteJSON['data'].addAll(toAdd['data']);
    }
  }
  return remoteJSON;
}

ImageProvider getRemoteBGI(Map<String, dynamic> content) {
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    // https://github.com/flutter/flutter/issues/73081#issuecomment-752050114
    for (Map<String, dynamic> iL in content['data']['game_info_list']) {
      if (iL['game']['biz'] == UsefulKV.get(style.relIF.useful[4])) {
        return NetworkImage(iL['backgrounds'][0]['background']['url']);
      }
    }
  }
  return const AssetImage(style.sAssetBGI);
}

List<RelPost> getRemotePosts(Map<String, dynamic> content) {
  List<RelPost> posts = [];
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    final List<dynamic> postsMap = content['data']['content']['posts'];
    for (final Map<String, dynamic> p in postsMap) {
      PostType t = PostType.info;
      String s = p['type']!;
      if (s == 'POST_TYPE_ANNOUNCE') {
        t = PostType.announce;
      } else if (s == 'POST_TYPE_INFO') {
        t = PostType.info;
      } else if (s == 'POST_TYPE_ACTIVITY') {
        t = PostType.activity;
      }
      posts.add(
        RelPost(
          id: p['id'],
          type: t,
          title: p['title']!,
          link: p['link']!,
          date: p['date']!,
        ),
      );
    }
  }
  return posts;
}

List<RelBanner> getRemoteBanners(Map<String, dynamic> content) {
  List<RelBanner> banners = [];
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    final List<dynamic> bannersMap = content['data']['content']['banners'];
    for (final Map<String, dynamic> b in bannersMap) {
      banners.add(
        RelBanner(
          id: b['id']!,
          imageURL: b['image']['url']!,
          onClickURL: b['image']['link']!,
        ),
      );
    }
  }
  return banners;
}
