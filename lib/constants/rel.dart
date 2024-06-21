class CnRel {
  static const List<String> useful = <String>[
    'c109ae56e9d2c13f0f5f3245fb548c0d',
    'ce30aa47577fe6d11d4a91d0e0133b9d',
    '4aa177fd18a020cf7735a89025dc690a',
    'a205701295300408e59f4d6ce66c2d8e',
  ];
  static const String language = 'zh-cn';
}

class OsRel {
  static const List<String> useful = <String>[
    '0b1d24cbf04c048f69de952cd44c1785',
    'cdba69916039acac927e0f9c86c3eb9f',
    '4aa177fd18a020cf7735a89025dc690a',
    'a205701295300408e59f4d6ce66c2d8e',
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
