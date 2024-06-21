import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_launcher/constants/global.dart' as style;
import 'package:easy_launcher/constants/useful.b91.dart';
import 'package:easy_launcher/constants/rel.dart';

Future<Map<String, dynamic>> getRemoteInfo(Locale locale) async {
  if (locale.languageCode == "zh") {
    style.relIF = CnRelInterface();
  } else {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    style.relIF.language = prefs.getString('languageCode') ?? 'en-us';
  }
  String url = await UsefulKV.get(style.relIF.useful[0]) +
      await UsefulKV.get(style.relIF.useful[2]);
  List<String> parameters = <String>[
    'launcher_id=${await UsefulKV.get(style.relIF.useful[1])}',
    'language=${style.relIF.language}',
  ];
  Uri httpPackageUrl = Uri.parse('$url?${parameters.join('&')}');
  Future<String> httpPackageInfo = http.read(httpPackageUrl);
  Map<String, dynamic> map = json.decode(
    utf8.decode(
      (await httpPackageInfo).codeUnits,
    ),
  );
  if (map['retcode'] == 0 && map['message'] == 'OK') {
    // TODO: THE CONST NUMBER IS NOT ROBUST.
    url = await UsefulKV.get(style.relIF.useful[0]) +
        await UsefulKV.get(style.relIF.useful[3]);
    String gameID = map['data']['game_info_list'][2]['game']['id'];
    parameters = <String>[
      'launcher_id=${await UsefulKV.get(style.relIF.useful[1])}',
      'game_id=$gameID',
      'language=${style.relIF.language}',
    ];
    httpPackageUrl = Uri.parse('$url?${parameters.join('&')}');
    httpPackageInfo = http.read(httpPackageUrl);
    Map<String, dynamic> toAdd = json.decode(
      utf8.decode(
        (await httpPackageInfo).codeUnits,
      ),
    );
    if (toAdd['retcode'] == 0 && toAdd['message'] == 'OK') {
      map['data'].addAll(toAdd['data']);
    }
  }
  return map;
}

ImageProvider getRemoteBGI(Map<String, dynamic> content) {
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    // https://github.com/flutter/flutter/issues/73081#issuecomment-752050114
    print(content);
    return NetworkImage(content['data']['game_info_list'][2]['backgrounds'][0]
        ['background']['url']);
    // TODO: THE CONST NUMBER IS NOT ROBUST.
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
