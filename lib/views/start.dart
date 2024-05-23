import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_launcher/constants/style.dart' as style;
import 'package:easy_launcher/constants/rel.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/utils/remote_api.dart';
import 'package:easy_launcher/views/settings.dart';

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
  int _postIndex = 0;
  bool isHovering = false;
  final CarouselController _controller = CarouselController();
  // The states make this part of widget unable to be simplified as a function
  // because Dart does not support referring or setting states by just passing
  // function parameters.
  ButtonStyle bs = ButtonStyle(
    shape: const WidgetStatePropertyAll(
      CircleBorder(),
    ),
    padding: WidgetStateProperty.all(
      const EdgeInsets.all(style.dButtonMargin),
    ),
    backgroundColor: WidgetStatePropertyAll(
      Colors.black.withOpacity(style.dOpacity),
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.grey.withOpacity(style.dOpacity);
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
        waitDuration: const Duration(milliseconds: style.iWaitMS),
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
      if (p.type == PostType.announce && tipAnnounce.length < style.iMaxPosts) {
        tipAnnounce.add(t);
      } else if (p.type == PostType.info && tipInfo.length < style.iMaxPosts) {
        tipInfo.add(t);
      } else if (p.type == PostType.activity &&
          tipActivity.length < style.iMaxPosts) {
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
      image: AssetImage(style.sAssetBGI),
    );
    List<List<Widget>> selectedPost = <List<Widget>>[];
    List<RelBanner> banners = <RelBanner>[];
    List<Widget> stacks = <Widget>[];
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
      stacks.addAll([
        Container(
          decoration: BoxDecoration(
            image: bg,
          ),
        ),
        Positioned(
          right: style.dButtonRight,
          bottom: style.dButtonBottom,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(style.dButtonRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: style.dBlurSigma,
                  sigmaY: style.dBlurSigma,
                  tileMode: TileMode.clamp,
                ),
                child: Container(
                  width: style.dButtonW,
                  height: style.dButtonH,
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
        ),
        Positioned(
          right: 2.0 * style.dButtonRight + style.dButtonDivW,
          // This can be simplified as Row + Divider.
          bottom: style.dButtonBottom,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(style.dButtonRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: style.dBlurSigma,
                  sigmaY: style.dBlurSigma,
                  tileMode: TileMode.clamp,
                ),
                child: Container(
                  width: style.dButtonW,
                  height: style.dButtonH,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () => buildSettings(context),
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
        ),
        FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.hasData &&
                (snapshot.data!.getBool('showPosts') ?? true)) {
              return Positioned(
                left: style.dButtonLeft,
                bottom: style.dButtonBottom,
                width: style.dPostW,
                height: style.dPostH,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(style.dPostRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: style.dBlurSigma,
                      sigmaY: style.dBlurSigma,
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
                            height: style.dPostDivH,
                            color: Colors.transparent,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _postIndex = 0;
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
                                    _postIndex = 1;
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
                                    _postIndex = 2;
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
                          const Divider(
                            height: style.dPostDivH,
                            color: Colors.transparent,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: selectedPost[_postIndex],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.hasData &&
                (snapshot.data!.getBool('showBanners') ?? true)) {
              return Positioned(
                left: style.dButtonLeft,
                bottom: style.dBannerBottom,
                width: style.dBannerW,
                height: style.dBannerH,
                child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: style.dCarouselImageH,
                    aspectRatio: style.dCarouselImageW / style.dCarouselImageH,
                    viewportFraction: style.dCarouselViewpointFraction,
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
                                    Radius.circular(style.dCarouselArrowRadius),
                                  ),
                                  child: Image.network(
                                    b.imageURL,
                                    fit: BoxFit.cover,
                                    width: style.dCarouselImageW,
                                    height: style.dCarouselImageH,
                                  ),
                                ),
                                isHovering
                                    ? Positioned(
                                        right: style.dZero,
                                        top: style.dCarouselArrowTop,
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
                                        left: style.dZero,
                                        top: style.dCarouselArrowTop,
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
              );
            }
            return Container();
          },
        ),
      ]);
    } else {
      stacks.addAll([
        Container(
          decoration: BoxDecoration(
            image: bg,
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(style.dDialogRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: style.dBlurSigma,
                sigmaY: style.dBlurSigma,
                tileMode: TileMode.clamp,
              ),
              child: Container(
                width: style.dDialogW,
                height: style.dDialogH,
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
      ]);
    }
    return Stack(
      alignment: AlignmentDirectional.center,
      children: stacks,
    );
  }
}
