import 'package:flutter/material.dart';

import 'view.dart';
import 'routes/add/add.dart';
import 'routes/event/event.dart';
const _route = '/home/calendar';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
		if (_route == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  View(),
				settings: settings
			);
		if (_route + '/add' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Add(),
				settings: settings
			);
		if (_route + '/event' == settings.name)
    	return MaterialPageRoute(
				builder: (_) =>  Event(event: settings.arguments),
				settings: settings
			);
	}
}
