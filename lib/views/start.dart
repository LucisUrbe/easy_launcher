import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/constants/rel.dart';
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
  int _postIndex = 1;
  bool isHovering = false;
  final CarouselController _controller = CarouselController();
  // The states make this part of widget unable to be simplified as a function
  // because Dart does not support referring or setting states by just passing
  // function parameters.
  ButtonStyle bs = ButtonStyle(
    shape: const MaterialStatePropertyAll(
      CircleBorder(),
    ),
    padding: MaterialStateProperty.all(
      const EdgeInsets.all(10.0),
    ),
    backgroundColor: MaterialStatePropertyAll(
      Colors.black.withOpacity(0.5),
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.grey.withOpacity(0.5);
      }
      return null;
    }),
  );

  List<List<Widget>> buildPosts(List<RelPost> posts) {
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
                  color: Colors.white54,
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
      if (p.type == PostType.announce && tipAnnounce.length < 3) {
        tipAnnounce.add(t);
      } else if (p.type == PostType.info && tipInfo.length < 3) {
        tipInfo.add(t);
      } else if (p.type == PostType.activity && tipActivity.length < 3) {
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
    List<RelBanner> banners = <RelBanner>[];
    // Tip: use `widget.variable` to pass a variable between widgets.
    if (widget.content.isNotEmpty) {
      bg = DecorationImage(
        fit: BoxFit.cover,
        image: getRemoteBGI(widget.content),
      );
      List<RelPost> posts = getRemotePosts(widget.content);
      posts.sort((a, b) => b.order.compareTo(a.order)); // descending
      selectedPost = buildPosts(posts);
      banners = getRemoteBanners(widget.content);
      banners.sort((a, b) => b.order.compareTo(a.order)); // descending
    }
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: bg,
          ),
        ),
        widget.content.isNotEmpty
            ? Positioned(
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
                          color: Colors.black12,
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
              )
            : Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                      tileMode: TileMode.clamp,
                    ),
                    child: Container(
                      width: 400.0,
                      height: 200.0,
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).remoteLoading,
                          style: const TextStyle(
                            inherit: false,
                            color: Colors.white,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        widget.content.isNotEmpty
            ? Positioned(
                right: 300.0,
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
                          color: Colors.black12,
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              S.of(context).settings,
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
              )
            : Container(),
        widget.content.isNotEmpty
            ? Positioned(
                left: 80.0,
                bottom: 80.0,
                width: 400.0,
                height: 105.0,
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
                        color: Colors.black26,
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
                                    _postIndex = 1;
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
                                    _postIndex = 2;
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
                                    _postIndex = 3;
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
                            children: selectedPost[_postIndex - 1],
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
                left: 80.0,
                bottom: 195.0,
                width: 400.0,
                height: 185.0,
                child: CarouselSlider(
                  carouselController: _controller,
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
                        (b) => Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              if (!await launchUrl(Uri.parse(b.onClickURL))) {
                                throw Exception(
                                    'Could not launch ${b.onClickURL}');
                              }
                            },
                            onHover: (bool hovering) {
                              setState(() => isHovering = hovering);
                            },
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  child: Image.network(
                                    b.imageURL,
                                    fit: BoxFit.cover,
                                    width: 690.0,
                                  ),
                                ),
                                isHovering
                                    ? Positioned(
                                        right: 0.0,
                                        top: 80.0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _controller.nextPage();
                                          },
                                          style: bs,
                                          child: const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                isHovering
                                    ? Positioned(
                                        left: 0.0,
                                        top: 80.0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _controller.previousPage();
                                          },
                                          style: bs,
                                          child: const Icon(
                                            Icons.keyboard_arrow_left,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            : Container(),
      ],
    );
  }
}
