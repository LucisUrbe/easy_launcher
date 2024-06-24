import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_launcher/constants/global.dart' as global;
import 'package:easy_launcher/constants/useful.b91.dart';
import 'package:easy_launcher/constants/rel.dart';

Future<Map<String, dynamic>> getRemoteMap(
  String path,
  Map<String, dynamic> queryParameters,
) async {
  final Future<Response<dynamic>> response = global.dio.get(
    path,
    queryParameters: queryParameters,
  );
  return (await response).data;
}

/// This function is a process that judges the global interface
/// according to the locale language code.
Future<void> setGlobalRelIF(Locale locale) async {
  if (locale.languageCode == "zh") {
    global.relIF = CnRelInterface();
    return; // Please add this return for special cases!
  }
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  global.relIF.language = prefs.getString('languageCode') ?? 'en-us';
}

Map<String, dynamic> mergeMaps(List<Map<String, dynamic>> mapList) {
  Map<String, dynamic> mergedMap = {
    "retcode": 0,
    "message": "OK",
    "data": {},
  };
  for (Map<String, dynamic> m in mapList) {
    if (m['retcode'] == 0 && m['message'] == 'OK') {
      mergedMap['data'].addAll(m['data']); // Oh no it's dynamic!
    }
  }
  return mergedMap;
}

Future<Map<String, dynamic>> getRemoteInfo(Locale locale) async {
  // Set the interface according to the locale.
  await setGlobalRelIF(locale);
  List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];
  String base = UsefulKV.get(global.relIF.useful[13]);
  Map<String, dynamic> queryParameters = {
    'launcher_id': UsefulKV.get(global.relIF.useful[14]),
  };
  List range(int from, int to) => List.generate(to - from + 1, (i) => i + from);
  List<Future<Map<String, dynamic>>> waitlist =
      <Future<Map<String, dynamic>>>[];
  for (int i in range(0, 4)) {
    waitlist.add(getRemoteMap(
      base + UsefulKV.get(global.relIF.useful[i]),
      queryParameters,
    ));
  }
  queryParameters.addAll({
    'language': global.relIF.language,
  });
  for (int i in range(5, 7)) {
    waitlist.add(getRemoteMap(
      base + UsefulKV.get(global.relIF.useful[i]),
      queryParameters,
    ));
  }
  for (Future<Map<String, dynamic>> m in waitlist) {
    maps.add(await m);
  }
  for (Map<String, dynamic> m in maps[0]['data']['launch_configs']) {
    if (m['game']['biz'] == UsefulKV.get(global.relIF.useful[11])) {
      queryParameters.addAll({
        'game_id': m['game']['id'],
      });
      maps.add(await getRemoteMap(
        base + UsefulKV.get(global.relIF.useful[8]),
        queryParameters,
      ));
    }
  }
  return mergeMaps(maps);
}

ImageProvider getRemoteBGI(Map<String, dynamic> content) {
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    // https://github.com/flutter/flutter/issues/73081#issuecomment-752050114
    for (Map<String, dynamic> iL in content['data']['game_info_list']) {
      if (iL['game']['biz'] == UsefulKV.get(global.relIF.useful[11])) {
        return NetworkImage(iL['backgrounds'][0]['background']['url']);
      }
    }
  }
  return const AssetImage(global.sAssetBGI);
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
