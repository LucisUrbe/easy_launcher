class CnRel {
  static const List<String> useful = <String>[
    '56d92f827361cbcf2ab2b5988118a35f',
    '3fb7959f15aa34293dd9800993c10f89',
  ];
  static const bool filterAdv = false;
  static const int launcherId = 18;
  static const String language = 'zh-cn';
}

class OsRel {
  static const List<String> useful = <String>[
    'a4e7bd2c0a31188bf490a9ecc3909d5f',
    'a124749e48d23604f2a38b5fefef27e4',
  ];
  static const bool filterAdv = false;
  static const int launcherId = 10;
  static const String language = 'en-us';
}

abstract class RelInterface {
  late List<String> useful;
  late bool filterAdv;
  late int launcherId;
  late String language;
}

class CnRelInterface implements RelInterface {
  @override
  List<String> get useful => CnRel.useful;
  @override
  set useful(List<String> _) {}
  @override
  bool get filterAdv => CnRel.filterAdv;
  @override
  set filterAdv(bool _) {}
  @override
  int get launcherId => CnRel.launcherId;
  @override
  set launcherId(int _) {}
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
  bool get filterAdv => OsRel.filterAdv;
  @override
  set filterAdv(bool _) {}
  @override
  int get launcherId => OsRel.launcherId;
  @override
  set launcherId(int _) {}
  @override
  String get language => OsRel.language;
  @override
  set language(String _) {}
}

enum PostType {
  announce,
  info,
  activity,
}

class RelPost {
  // Do not declare "tittle" here!
  int order = -1;
  String postID = ""; // This item is often ignored.
  PostType type = PostType.info;
  String title = "";
  String url = "about:blank";
  String showTime = "MM/dd";

  RelPost({
    required this.order,
    required this.postID,
    required this.type,
    required this.title,
    required this.url,
    required this.showTime,
  });
}

class RelBanner {
  int order = -1;
  String imageURL = "about:blank"; // "img", 690x320, PNG or JPG
  String onClickURL = "about:blank"; // "url"
  String bannerID = ""; // This item is often ignored.
  String name = ""; // This item is always equal to "".

  RelBanner({
    required this.order,
    required this.imageURL,
    required this.onClickURL,
    required this.bannerID,
    required this.name,
  });
}
