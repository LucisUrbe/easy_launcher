import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_launcher/generated/l10n.dart';
import 'package:easy_launcher/views/start.dart';
import 'package:easy_launcher/utils/remote_api.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool showLeading = false;
  bool showTrailing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getRemoteContent(),
      builder:
          (BuildContext context, AsyncSnapshot<String> snapshot) {
        DecorationImage bg = const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('lib/assets/background.png'),
        );
        Expanded sv = startView(context, {});
        if (snapshot.hasData) {
          Map<String, dynamic> map = jsonDecode(snapshot.data!);
          bg = DecorationImage(
            fit: BoxFit.cover,
            image: getRemoteBGI(map),
          );
          sv = startView(context, map);
        }
        return Container(
          decoration: BoxDecoration(
            image: bg,
          ),
          child: Row(
            children: <Widget>[
              NavigationRail(
                backgroundColor: Colors.black.withOpacity(0.2),
                selectedIndex: _selectedIndex,
                groupAlignment: 0.0,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                leading: showLeading
                    ? FloatingActionButton(
                        elevation: 0,
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        child: const Icon(Icons.add),
                      )
                    : const SizedBox(),
                trailing: showTrailing
                    ? IconButton(
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                        icon: const Icon(Icons.more_horiz_rounded),
                      )
                    : const SizedBox(),
                destinations: <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: const Icon(
                      Icons.rocket_outlined,
                      color: Colors.white,
                    ),
                    selectedIcon: const Icon(Icons.rocket_rounded),
                    label: Text(
                      S.of(context).start,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    selectedIcon: const Icon(Icons.book),
                    label: Text(
                      S.of(context).start,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: const Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                    selectedIcon: const Icon(Icons.star),
                    label: Text(
                      S.of(context).start,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                thickness: 1.0,
                width: 1.0,
                color: Colors.transparent,
              ),
              // This is the main content.
              <Expanded>[
                sv,
                sv,
                sv,
              ][_selectedIndex],
            ],
          ),
        );
      },
    );
  }
}
