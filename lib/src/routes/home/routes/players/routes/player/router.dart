import 'package:flutter/material.dart';

import 'routes/add_invitation/add_invitation.dart';

import 'player.dart';
const _route = '/home/players/player';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
 	return {
		_route: MaterialPageRoute(
			builder: (_) =>  Player(player: (settings.arguments as List)[0], updateUpperPage: (settings.arguments as List)[1]),
			settings: settings,
		),
		_route + '/addInvitation': MaterialPageRoute(
			builder: (_) =>  AddInvitation(),
			settings: settings
		)
	};
}
