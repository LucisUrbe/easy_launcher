class CnRel {
  static const List<String> useful = <String>[
    '2499457a8f7202ab32ec0d2474f1f9d9',
    '84929586547257d764c648342f266afb',
    'f4e944335282665a3ef672ff2e5dd36b',
    '975a3fedbdcd5bb42ffc014a13868b2f',
    'a82b477c048085d1b207d19f88803f1c',
    '8eb4882478c303886ef77abb9726ced7',
    'df0e9bb2c90b77058a307808944708e7',
    '22203745cabcbf4c9d8c8f64f603c83d',
    '8b926ca329dfb31daa1211d0e158e05e',
    'd9780e62c73edb5bfc42d5cd1a47331b',
    '97c336f09c476271c8709272e6849e9a',
    '0192bc43f6f7e8c8b3bb716228f25ff1',
    'a0a0a6874525f7e539c58da39a26ec1c',
    '0103195654c1d28a0eae6490a495df13',
    '79cbd9d37bc5e0a27cd70483c79a65e9',
  ];
  static const String language = 'zh-cn';
}

class OsRel {
  static const List<String> useful = <String>[
    '2499457a8f7202ab32ec0d2474f1f9d9',
    '84929586547257d764c648342f266afb',
    'f4e944335282665a3ef672ff2e5dd36b',
    '975a3fedbdcd5bb42ffc014a13868b2f',
    'a82b477c048085d1b207d19f88803f1c',
    '8eb4882478c303886ef77abb9726ced7',
    'df0e9bb2c90b77058a307808944708e7',
    '22203745cabcbf4c9d8c8f64f603c83d',
    '8b926ca329dfb31daa1211d0e158e05e',
    'f2036282d37b2835e1d8955dc8c2a7c8',
    '08f25efea4452d4308c82b6cf9def985',
    '5853d87bc37fb515e55803dc6ac4f490',
    'e2d010c335e2c39294d00bd1bf6d7ce3',
    'd8566659782fe319ef1ce16210765d59',
    '395ccfcd6c8847d9684be5e0dbfeefb4',
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
