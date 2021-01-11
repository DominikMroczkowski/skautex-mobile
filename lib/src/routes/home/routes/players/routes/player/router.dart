import 'package:flutter/material.dart';

import 'routes/add_invitation/add_invitation.dart';
import 'routes/add_contact/add_contact.dart';

import 'player.dart';
const _route = '/home/players/player';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
 	return {
		_route: MaterialPageRoute(
			builder: (_) =>  Player(player: (settings.arguments as List)[0], updateUpperPage: (settings.arguments as List)[1]),
			settings: settings,
		),
		_route + '/addInvitation': MaterialPageRoute(
			builder: (_) =>  AddInvitation(player: (settings.arguments as List)[0], updateUpperPage: (settings.arguments as List)[1]),
			settings: settings
		),
		_route + '/addContact': MaterialPageRoute(
			builder: (_) =>  AddContact(player: (settings.arguments as List)[0], updateUpperPage: (settings.arguments as List)[1]),
			settings: settings
		)
	};
}
