import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/constants/cn_rel.dart';
import 'package:easy_launcher/utils/remote_api.dart';

class StartPage extends StatefulWidget {
  final Map<String, dynamic> content;
  const StartPage({
    super.key,
    required this.content,
  });

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int selectedPostIndex = 1;
  // This state makes this part of widget unable to be simplified as a function
  // because Dart does not support referring or setting a state by just passing
  // function parameters.

  List<List<Widget>> buildPosts(List<CnRelPost> posts) {
    List<Tooltip> tipAnnounce = <Tooltip>[];
    List<Tooltip> tipInfo = <Tooltip>[];
    List<Tooltip> tipActivity = <Tooltip>[];
    for (final p in posts) {
      Tooltip t = Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: p.title,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: "   ${p.showTime}   ", // it is a TEMPORARY way to align
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              TextSpan(
                text: p.title,
                style: const TextStyle(
                  color: Colors.white,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    if (!await launchUrl(Uri.parse(p.url))) {
                      throw Exception('Could not launch ${p.url}');
                    }
                  },
              ),
            ],
          ),
        ),
      );
      if (p.type == PostType.announce) {
        tipAnnounce.add(t);
      } else if (p.type == PostType.info) {
        tipInfo.add(t);
      } else if (p.type == PostType.activity) {
        tipActivity.add(t);
      }
    }
    return [
      tipAnnounce,
      tipInfo,
      tipActivity,
    ];
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage bg = const DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('lib/assets/background.png'),
    );
    List<List<Widget>> selectedPost = <List<Widget>>[];
    List<CnRelBanner> banners = <CnRelBanner>[];
    // Tip: use `widget.variable` to pass a variable between widgets.
    if (widget.content.isNotEmpty) {
      bg = DecorationImage(
        fit: BoxFit.cover,
        image: getRemoteBGI(widget.content),
      );
      List<CnRelPost> posts = getRemotePosts(widget.content);
      posts.sort((a, b) => b.order.compareTo(a.order)); // descending
      selectedPost = buildPosts(posts);
      banners = getRemoteBanners(widget.content);
      banners.sort((a, b) => b.order.compareTo(a.order)); // descending
    }
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: bg,
            ),
          ),
          Positioned(
            right: 120.0,
            bottom: 80.0,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                    tileMode: TileMode.clamp,
                  ),
                  child: Container(
                    width: 150.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      color: Colors.white10,
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          S.of(context).launchGame,
                          style: const TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          widget.content.isNotEmpty
              ? Positioned(
                  left: 50.0,
                  bottom: 80.0,
                  width: 350.0,
                  height: 150.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 5.0,
                        tileMode: TileMode.clamp,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Divider(
                              height: 5.0,
                              color: Colors.transparent,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPostIndex = 1;
                                    });
                                  },
                                  child: Text(
                                    S.of(context).announce,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPostIndex = 2;
                                    });
                                  },
                                  child: Text(
                                    S.of(context).info,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedPostIndex = 3;
                                    });
                                  },
                                  child: Text(
                                    S.of(context).activity,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: selectedPost[selectedPostIndex - 1],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          widget.content.isNotEmpty
              ? Positioned(
                  left: 50.0,
                  bottom: 240.0,
                  width: 350.0,
                  height: 162.0,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 320.0,
                      aspectRatio: 690.0 / 320.0,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: banners
                        .map(
                          (b) => ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Image.network(
                                  b.imageURL,
                                  fit: BoxFit.cover,
                                  width: 690.0,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
