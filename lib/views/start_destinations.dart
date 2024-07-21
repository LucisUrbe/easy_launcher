import 'package:flutter/material.dart';

List<NavigationRailDestination> buildNRDs(Map<String, dynamic> mergedData) {
  List<NavigationRailDestination> destinations = <NavigationRailDestination>[];
  if (mergedData.containsKey('games')) {
    for (Map<String, dynamic> game in mergedData['games']) {
      destinations.add(
        NavigationRailDestination(
          icon: Image.network(
            game['display']['icon']['url'],
            width: 40.0,
            height: 40.0,
          ),
          label: Text(game['biz'].split('_')[0]), // game['display']['name']
        ),
      );
    }
  }
  return destinations;
}
