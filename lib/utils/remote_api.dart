import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:easy_launcher/constants/useful.b91.dart';
import 'package:easy_launcher/constants/cn_rel.dart';

Future<String> getRemoteContent() async {
  final String url = await UsefulKV.get(CnRel.useful[0]);
  final List<String> parameters = <String>[
    'key=${await UsefulKV.get(CnRel.useful[1])}',
    'filter_adv=${CnRel.filterAdv.toString()}',
    'launcher_id=${CnRel.launcherId.toString()}',
    'language=${CnRel.language}',
  ];
  final Uri httpPackageUrl = Uri.parse('$url?${parameters.join('&')}');
  final String httpPackageInfo = await http.read(httpPackageUrl);
  return httpPackageInfo;
}

Future<ImageProvider> getRemoteBGI(Future<String> content) async {
  final map = jsonDecode(await content);
  if (map['retcode'] == 0 && map['message'] == 'OK') {
    return NetworkImage(map['data']['adv']['background']);
  }
  return const AssetImage('lib/assets/background.png');
}

Future<List<CnRelPost>> getRemotePosts(Future<String> content) async {
  List<CnRelPost> posts = [];
  final map = jsonDecode(await content);
  if (map['retcode'] == 0 && map['message'] == 'OK') {
    final List<Map<String, String>> postsMap = map['data']['post'];
    for (final Map<String, String> p in postsMap) {
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
        CnRelPost(
          order: int.parse(p['order']!),
          postID: p['post_id']!,
          type: t,
          title: p['title']!,
          url: p['url']!,
          showTime: p['show_time']!,
        ),
      );
    }
  }
  return posts;
}

Future<List<CnRelBanner>> getRemoteBanners(Future<String> content) async {
  List<CnRelBanner> banners = [];
  final map = jsonDecode(await content);
  if (map['retcode'] == 0 && map['message'] == 'OK') {
    final List<Map<String, String>> bannersMap = map['data']['banners'];
    for (final Map<String, String> b in bannersMap) {
      banners.add(
        CnRelBanner(
          order: int.parse(b['order']!),
          imageURL: b['img']!,
          onClickURL: b['url']!,
          bannerID: b['banner_id']!,
          name: b['name']!,
        ),
      );
    }
  }
  return banners;
}
