import 'package:flutter/material.dart';

import 'routes/player/router.dart' as player;
import 'routes/add_player/add_player.dart';
import 'routes/edit_player/edit_player.dart';

import 'players.dart';
const _route = '/home/players';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
	var routes = {
		_route: MaterialPageRoute(
			builder: (_) =>  Players(),
			settings: settings
		),
		_route + '/editPlayer': MaterialPageRoute(
			builder: (_) =>  EditPlayer(player: (settings.arguments as List)[0], updateUpperPage: (settings.arguments as List)[1]),
			settings: settings
		),
		_route + '/addPlayer': MaterialPageRoute(
			builder: (_) =>  AddPlayer(updateUpperPage: settings.arguments),
			settings: settings
		)
	};
	routes.addAll(player.routes(settings));
	return routes;
}
