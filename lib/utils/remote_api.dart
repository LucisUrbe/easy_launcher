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
