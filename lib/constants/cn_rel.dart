class CnRel {
  static const List<String> useful = <String>[
    '56d92f827361cbcf2ab2b5988118a35f',
    '3fb7959f15aa34293dd9800993c10f89',
  ];
  static const bool filterAdv = false;
  static const int launcherId = 18;
  static const String language = 'zh-cn';
}

enum PostType {
  announce,
  info,
  activity,
}

class CnRelPost {
  // Do not declare "tittle" here!
  int order = -1;
  String postID = ""; // This item is often ignored.
  PostType type = PostType.info;
  String title = "";
  String url = "about:blank";
  String showTime = "MM/dd";

  CnRelPost({
    required this.order,
    required this.postID,
    required this.type,
    required this.title,
    required this.url,
    required this.showTime,
  });
}

class CnRelBanner {
  int order = -1;
  String imageURL = "about:blank"; // "img", 690x320, PNG or JPG
  String onClickURL = "about:blank"; // "url"
  String bannerID = ""; // This item is often ignored.
  String name = ""; // This item is always equal to "".

  CnRelBanner({
    required this.order,
    required this.imageURL,
    required this.onClickURL,
    required this.bannerID,
    required this.name,
  });
}
