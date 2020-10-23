import 'package:flutter/material.dart';

import 'routes/player/player.dart';
import 'routes/add_player/add_player.dart';
import 'routes/edit_player/edit_player.dart';

import 'view.dart';
const _route = '/home/players';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
		else if (_route + '/player' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Player(),
				settings: settings
			);
		else if (_route + '/editPlayer' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  EditPlayer(),
				settings: settings
			);
		else if (_route + '/addPlayer' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  AddPlayer(),
				settings: settings
			);
	}
}
