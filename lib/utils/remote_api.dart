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

ImageProvider getRemoteBGI(Map<String, dynamic> content) {
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    return NetworkImage(content['data']['adv']['background']);
  }
  return const AssetImage('lib/assets/background.png');
}

List<CnRelPost> getRemotePosts(Map<String, dynamic> content) {
  List<CnRelPost> posts = [];
  if (content['retcode'] == 0 && content['message'] == 'OK') {
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

List<CnRelBanner> getRemoteBanners(Map<String, dynamic> content) {
  List<CnRelBanner> banners = [];
  if (content['retcode'] == 0 && content['message'] == 'OK') {
    final List<dynamic> bannersMap = content['data']['banner'];
    for (final Map<String, dynamic> b in bannersMap) {
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
