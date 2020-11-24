import 'package:flutter/material.dart';

import 'view.dart';
import 'routes/add/add.dart';
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
	}
}
