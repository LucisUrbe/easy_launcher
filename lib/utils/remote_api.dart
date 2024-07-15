import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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

Map<String, dynamic> mergeMaps(List<Map<String, dynamic>> mapList) {
  Map<String, dynamic> mergedData = {};
  for (Map<String, dynamic> m in mapList) {
    if (m['retcode'] == 0 && m['message'] == 'OK') {
      mergedData.addAll(m['data']);
    }
  }
  return mergedData;
}

Future<Map<String, dynamic>> getRemoteInfo() async {
  // Declare base information.
  List<Map<String, dynamic>> maps = <Map<String, dynamic>>[];
  String base = UsefulKV.get(global.relIF.useful[13]);
  Map<String, dynamic> queryParameters = {
    'launcher_id': UsefulKV.get(global.relIF.useful[14]),
  };
  // Put async requests in the waitlist.
  List range(int from, int to) => List.generate(to - from + 1, (i) => i + from);
  List<Future<Map<String, dynamic>>> waitlist =
      <Future<Map<String, dynamic>>>[];
  for (int i in range(0, 4)) {
    waitlist.add(getRemoteMap(
      base + UsefulKV.get(global.relIF.useful[i]),
      queryParameters,
    ));
  }
  // Update necessary parameters and continue putting in the waitlist.
  queryParameters.addAll({
    'language': global.relIF.language,
  });
  for (int i in range(5, 7)) {
    waitlist.add(getRemoteMap(
      base + UsefulKV.get(global.relIF.useful[i]),
      queryParameters,
    ));
  }
  // Time's up! Get all the responses.
  for (Future<Map<String, dynamic>> m in waitlist) {
    maps.add(await m);
  }
  // We need to get a parameter from the response.
  for (Map<String, dynamic> m in maps[0]['data']['launch_configs']) {
    if (m['game']['biz'] == UsefulKV.get(global.relIF.useful[11])) {
      queryParameters.addAll({
        'game_id': m['game']['id'],
      });
      // The final request.
      maps.add(await getRemoteMap(
        base + UsefulKV.get(global.relIF.useful[8]),
        queryParameters,
      ));
      break;
    }
  }
  return mergeMaps(maps);
}

ImageProvider getRemoteBGI(Map<String, dynamic> mergedData) {
  // https://github.com/flutter/flutter/issues/73081#issuecomment-752050114
  if (mergedData.containsKey('game_info_list')) {
    for (Map<String, dynamic> iL in mergedData['game_info_list']) {
      if (iL['game']['biz'] == UsefulKV.get(global.relIF.useful[11])) {
        return NetworkImage(iL['backgrounds'][0]['background']['url']);
      }
    }
  }
  return const AssetImage(global.sAssetBGI);
}

List<RelPost> getRemotePosts(Map<String, dynamic> mergedData) {
  List<RelPost> posts = [];
  if (mergedData.containsKey('content') &&
      mergedData['content'].containsKey('posts')) { // Oh no it's dynamic!
    final List<dynamic> postsMap = mergedData['content']['posts'];
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

List<RelBanner> getRemoteBanners(Map<String, dynamic> mergedData) {
  List<RelBanner> banners = [];
  if (mergedData.containsKey('content') &&
      mergedData['content'].containsKey('banners')) { // Oh no it's dynamic!
    final List<dynamic> bannersMap = mergedData['content']['banners'];
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
