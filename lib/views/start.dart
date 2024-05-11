import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/constants/cn_rel.dart';
import 'package:easy_launcher/utils/remote_api.dart';

Expanded startView(BuildContext context, Map<String, dynamic> content) {
  if (content.isNotEmpty) {
    List<CnRelBanner> banners = getRemoteBanners(content);
    List<CnRelPost> posts = getRemotePosts(content);
  }
  return Expanded(
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Positioned(
          right: 100.0,
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
                  width: 100.0,
                  height: 30.0,
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
        content.isNotEmpty
            ? Positioned(
                left: 100.0,
                bottom: 80.0,
                width: 300.0,
                height: 100.0,
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
                        children: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  S.of(context).announce,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  S.of(context).info,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
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
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              S.of(context).announce,
                              style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    ),
  );
}
