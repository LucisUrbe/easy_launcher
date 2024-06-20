import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_launcher/constants/global.dart' as style;
import 'package:easy_launcher/constants/useful.b91.dart';
import 'package:easy_launcher/constants/rel.dart';

Future<String> getRemoteContent(Locale locale) async {
  if (locale.languageCode == "zh") {
    style.relIF = CnRelInterface();
  } else {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    style.relIF.language = prefs.getString('languageCode') ?? 'en-us';
  }
  final String url = await UsefulKV.get(style.relIF.useful[0]) +
      await UsefulKV.get(style.relIF.useful[2]); // TODO: more cases.
  final List<String> parameters = <String>[
    'launcher_id=${await UsefulKV.get(style.relIF.useful[1])}',
    'language=${style.relIF.language}',
  ];
  final Uri httpPackageUrl = Uri.parse('$url?${parameters.join('&')}');
  final Future<String> httpPackageInfo = http.read(httpPackageUrl);
  return httpPackageInfo;
}

ImageProvider getRemoteBGI(Map<String, dynamic> content) {
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    // https://github.com/flutter/flutter/issues/73081#issuecomment-752050114
    print(content);
    return NetworkImage(
        content
        ['data']
        ['game_info_list']
        [2]
        ['backgrounds']
        [0]
        ['background']
        ['url']
    );
    // TODO: THE CONST NUMBER IS NOT ROBUST.
  }
  return const AssetImage(style.sAssetBGI);
}

List<RelPost> getRemotePosts(Map<String, dynamic> content) {
  List<RelPost> posts = [];
  if (content['retcode'] == 0 && content['message'] != 'OK') {
    final List<dynamic> postsMap = content['data']['post'];
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

List<RelBanner> getRemoteBanners(Map<String, dynamic> content) {
  List<RelBanner> banners = [];
  if (content['retcode'] == 0 && content['message'] != 'OK') {
    final List<dynamic> bannersMap = content['data']['banner'];
    for (final Map<String, dynamic> b in bannersMap) {
      banners.add(
        RelBanner(
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
