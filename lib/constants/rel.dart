class CnRel {
  static const List<String> useful = <String>[
    '0103195654c1d28a0eae6490a495df13',
    '79cbd9d37bc5e0a27cd70483c79a65e9',
    'df0e9bb2c90b77058a307808944708e7',
    '8b926ca329dfb31daa1211d0e158e05e',
    '0192bc43f6f7e8c8b3bb716228f25ff1',
  ];
  static const String language = 'zh-cn';
}

class OsRel {
  static const List<String> useful = <String>[
    'd8566659782fe319ef1ce16210765d59',
    '395ccfcd6c8847d9684be5e0dbfeefb4',
    'df0e9bb2c90b77058a307808944708e7',
    '8b926ca329dfb31daa1211d0e158e05e',
    '5853d87bc37fb515e55803dc6ac4f490',
  ];
  static String language = 'en-us';
}

abstract class RelInterface {
  late List<String> useful;
  late String language;
}

class CnRelInterface implements RelInterface {
  @override
  List<String> get useful => CnRel.useful;
  @override
  set useful(List<String> _) {}
  @override
  String get language => CnRel.language;
  @override
  set language(String _) {}
}

class OsRelInterface implements RelInterface {
  @override
  List<String> get useful => OsRel.useful;
  @override
  set useful(List<String> _) {}
  @override
  String get language => OsRel.language;
  @override
  set language(String value) => OsRel.language = value;
}

enum PostType {
  announce,
  info,
  activity,
}

class RelPost {
  String id = '';
  PostType type = PostType.info;
  String title = '';
  String link = 'about:blank';
  String date = 'MM/dd';

  RelPost({
    required this.id,
    required this.type,
    required this.title,
    required this.link,
    required this.date,
  });
}

class RelBanner {
  String id = ''; // This item is often ignored.
  String imageURL = 'about:blank'; // "img", 690x320, PNG or JPG
  String onClickURL = 'about:blank'; // "url"

  RelBanner({
    required this.id,
    required this.imageURL,
    required this.onClickURL,
  });
}
