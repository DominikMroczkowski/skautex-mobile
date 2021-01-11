import 'package:flutter/material.dart';

import 'calendar.dart';
import 'routes/add/add.dart';
import 'routes/event/event.dart';
const _route = '/home/calendar';

Map<String, MaterialPageRoute> routes(RouteSettings settings) {
	return {
		_route: MaterialPageRoute(
			builder: (_) =>  Calendar(),
			settings: settings
		),
		_route + '/add': MaterialPageRoute(
			builder: (_) =>  Add(),
			settings: settings
		),
		_route + '/event': MaterialPageRoute(
			builder: (_) =>  Event(event: settings.arguments),
			settings: settings
		),
		_route + '/event/edit': MaterialPageRoute(
			builder: (_) =>  Add(event: (settings.arguments as List)[0], eventBloc: (settings.arguments as List)[1]),
			settings: settings
		)
	};
}
